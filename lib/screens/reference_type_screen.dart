import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/reference_types_api.dart';
import 'package:personal_phone_dictionary/components/add_referencetype_sheet_componenet.dart';
import 'package:personal_phone_dictionary/components/filtration_appbar_component.dart';
import 'package:personal_phone_dictionary/components/toasts.dart';
import 'package:personal_phone_dictionary/models/reference_type_model.dart';
import 'package:personal_phone_dictionary/utils/common.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class ReferenceTypeScreen extends StatefulWidget {
  const ReferenceTypeScreen({super.key});

  @override
  State<ReferenceTypeScreen> createState() => _ReferenceTypeScreenState();
}

class _ReferenceTypeScreenState extends State<ReferenceTypeScreen> {
  final filtrationItems = ["All", "Active", "In Active"];

  int _selectedFiltraionIndex = 0;

  Widget _filtrationSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _filtrationSectionItem(0, filtrationItems[0]),
        const SizedBox(
          width: 10,
        ),
        _filtrationSectionItem(1, filtrationItems[1]),
        const SizedBox(
          width: 10,
        ),
        _filtrationSectionItem(2, filtrationItems[2]),
      ],
    );
  }

  Widget _filtrationSectionItem(int index, String title) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        setState(() {
          _selectedFiltraionIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: _selectedFiltraionIndex == index
                ? Colors.blue[900]
                : const Color.fromRGBO(247, 248, 253, 1),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: _selectedFiltraionIndex == index
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    ));
  }

  Future<void> deleteReferenceType(int referenceTypeID) async {
    try {
      String msg = await deleteReferenceTypes(referenceTypeID);
      if (msg == "") {
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
              message: msg.replaceAll("Exception: Exception: ", ""),
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

  Widget addressListItem(ReferenceTypeModel model) {
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
                model.referenceTypeTitle,
                style: GoogleFonts.raleway(fontSize: 18),
              ),
              Text(
                CommonFunctions.getTimeAgo(datetime: model.entryDate),
                style: GoogleFonts.raleway(fontSize: 12),
              )
            ],
          ),
          Divider(
            color: Colors.grey[200],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    model.inActive == true ? "In-Active" : "Active",
                    style: GoogleFonts.raleway(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  AddReferencetypeSheetComponenet(
                    referenceTypeModel: model,
                    edit: true,
                    widget: Container(
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
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      CommonFunctions.deleteRecordConfirmDialog(
                          context: context,
                          ontap: () {
                            deleteReferenceType(model.referenceTypeID);
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<List<ReferenceTypeModel>> getreferenceTypes() async {
    Future<List<ReferenceTypeModel>> referenceTypes =
        getAllReferenceTypes(null);
    return referenceTypes;
  }

  List<ReferenceTypeModel> _getFilteredData(List<ReferenceTypeModel> data) {
    if (_selectedFiltraionIndex == 0) {
      return data;
    } else if (_selectedFiltraionIndex == 1) {
      return data.where((item) {
        return item.inActive == false;
      }).toList();
    } else {
      return data.where((item) {
        return item.inActive == true;
      }).toList();
    }
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
              title: "Reference Types",
            ),
            const SizedBox(
              height: 20,
            ),
            _filtrationSection(),
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
                              "No Reference Types found!",
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
