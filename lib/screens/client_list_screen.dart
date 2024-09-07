import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/client_api.dart';
import 'package:personal_phone_dictionary/components/filtration_appbar_component.dart';
import 'package:personal_phone_dictionary/components/toasts.dart';
import 'package:personal_phone_dictionary/models/client_model.dart';
import 'package:personal_phone_dictionary/models/delete_record_model.dart';
import 'package:personal_phone_dictionary/models/get_where_model.dart';
import 'package:personal_phone_dictionary/utils/common.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  State<ClientListScreen> createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  SecureStorage secureStorage = SecureStorage();

  Future<void> deleteReferenceType(int clientID) async {
    String userID = await secureStorage.readSecureData("userID");
    String companyID = await secureStorage.readSecureData("companyID");
    try {
      DeleteRecordModel deleteRecordModel = DeleteRecordModel(
          userID: int.parse(userID),
          companyID: int.parse(companyID),
          masterID: clientID);

      final response = await deleteClientAsync(deleteRecordModel);
      if (response.success == true) {
        if (mounted) {
          ToastUtils.showOkToast(
              context: context,
              message: "Record Deleted Successfully!",
              icon: const Icon(Icons.check));
          Navigator.of(context).pushNamed("/referencetypelist");
        }
      } else {
        if (mounted) {
          ToastUtils.showErrorToast(
              context: context,
              message: response.message!,
              icon: const Icon(Icons.error));
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ToastUtils.showErrorToast(
            context: context,
            message: e.toString().replaceAll("Exception: Exception: ", ""),
            icon: const Icon(Icons.error));
      }
    }
  }

  Widget addressListItem(ClientModel model) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [],
        color: const Color.fromRGBO(247, 248, 253, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.clientName!,
                style: GoogleFonts.raleway(fontSize: 18),
              ),
              Text(
                CommonFunctions.getTimeAgo(datetime: model.entryDate!),
                style: GoogleFonts.raleway(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            model.phoneNumber!,
            style: GoogleFonts.raleway(fontSize: 14),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            model.whatsappNumber!,
            style: GoogleFonts.raleway(fontSize: 14),
          ),
          Divider(
            color: Colors.grey[200],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  CommonFunctions.deleteRecordConfirmDialog(
                      context: context,
                      ontap: () {
                        deleteReferenceType(model.clientID!);
                      });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<List<ClientModel>> getreferenceTypes() async {
    String userID = await secureStorage.readSecureData("userID");
    String companyID = await secureStorage.readSecureData("companyID");
    GetWhereModel getWhereModel = GetWhereModel(
        userID: int.parse(userID),
        companyID: int.parse(companyID),
        masterID: 0);

    final response = await getReferenceTypeListAysnc(getWhereModel);
    if (response.success) {
      return response.data!;
    } else {
      return [];
    }
  }

  List<ClientModel> _getFilteredData(List<ClientModel> data) {
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
            const FiltrationAppbarComponent(
              title: "Customers",
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getreferenceTypes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Clients found!",
                              style: GoogleFonts.raleway(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed("/dashboard");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Constants.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Go Back",
                                  style: GoogleFonts.raleway(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      var data = snapshot.data!;

                      var filteredData = _getFilteredData(data);

                      return RefreshIndicator(
                        onRefresh: getreferenceTypes,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return addressListItem(filteredData[index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}
