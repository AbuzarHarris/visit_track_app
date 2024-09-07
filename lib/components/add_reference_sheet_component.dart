import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/reference_types_api.dart';
import 'package:personal_phone_dictionary/api/references_api.dart';
import 'package:personal_phone_dictionary/components/form_input_component.dart';
import 'package:personal_phone_dictionary/components/single_dropdown_component.dart';
import 'package:personal_phone_dictionary/components/toasts.dart';
import 'package:personal_phone_dictionary/models/dropdown_models.dart';
import 'package:personal_phone_dictionary/models/reference_model.dart';
import 'package:personal_phone_dictionary/utils/common.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

class AddReferenceSheetComponent extends StatefulWidget {
  final Widget widget;
  final ReferenceModel? referenceModel;
  final bool edit;
  const AddReferenceSheetComponent(
      {super.key,
      required this.widget,
      this.referenceModel,
      this.edit = false});

  @override
  State<AddReferenceSheetComponent> createState() =>
      _AddReferenceSheetComponentState();
}

class _AddReferenceSheetComponentState
    extends State<AddReferenceSheetComponent> {
  final TextEditingController _referenceNameController =
      TextEditingController();
  String? referenceTypeTitle;
  String? referenceTypeID;
  bool? inActive = false;
  int referenceID = 0;

  Future<void> _onSubmit() async {
    try {
      SecureStorage secureStorage = SecureStorage();
      String userID = await secureStorage.readSecureData("userID");
      String companyID = await secureStorage.readSecureData("companyID");

      ReferenceModel model = ReferenceModel(
          companyID: int.parse(userID),
          userID: int.parse(companyID),
          referenceID: widget.referenceModel != null
              ? widget.referenceModel!.referenceTypeID
              : 0,
          referenceTypeID: int.parse("0$referenceTypeID"),
          referenceTitle: _referenceNameController.text,
          inActive: inActive ?? false,
          entryDate: DateTime.now().toString(),
          referenceTypeTitle: referenceTypeTitle ?? "");

      var apiResponse = await insertUpdateReferenceAsync(model);

      if (apiResponse.success) {
        if (mounted) {
          ToastUtils.showOkToast(
              context: context,
              message: "Record Saved Successfully!",
              icon: const Icon(Icons.check));
          _clearValues();
          Navigator.of(context).pop();
          if (widget.edit == true) {
            Navigator.of(context).pushNamed("/referenceslist");
          }
        } else {
          if (mounted) {
            ToastUtils.showErrorToast(
                context: context,
                message: apiResponse.message.toString(),
                icon: const Icon(Icons.error));
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showErrorToast(
            context: context,
            message: e.toString(),
            icon: const Icon(Icons.error));
      }
    }
  }

  void _clearValues() {
    referenceID = 0;
    _referenceNameController.text = "";
    inActive = false;
    referenceTypeID = null;
    referenceTypeTitle = null;
  }

  Future<List<ReferenceTypeDropdownModel>> loadReferenceTypeDropdown() async {
    var data = await getReferenceTypeDropdown();
    return data;
  }

  void _addReferenceSheet() {
    if (widget.referenceModel != null) {
      _referenceNameController.text = widget.referenceModel!.referenceTitle;
      referenceTypeID = widget.referenceModel!.referenceTypeID.toString();
      referenceID = widget.referenceModel!.referenceID;
      inActive = widget.referenceModel!.inActive;
      referenceTypeTitle = widget.referenceModel!.referenceTypeTitle;
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          clipBehavior: Clip.antiAlias,
          // default is Clip.none
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          builder: (_) {
            return DraggableScrollableSheet(
              initialChildSize: 0.7,
              maxChildSize: 0.7,
              shouldCloseOnMinExtent: false,
              expand: false,
              builder: (_, controller) {
                return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.edit == true
                                ? "Edit Reference"
                                : "Add Reference",
                            style: GoogleFonts.raleway(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: FormInputComponent(
                                  controller: _referenceNameController,
                                  autofocus: true,
                                  hintText: "Name",
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: FutureBuilder(
                                future: loadReferenceTypeDropdown(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<String>? stringList = snapshot.data
                                        ?.map((model) => model.name)
                                        .toList();

                                    return SingleDropdownComponent(
                                      items: stringList ?? [],
                                      labelText: "Reference Type",
                                      selectedItem: referenceTypeTitle,
                                      showSearchBox: true,
                                      onChange: (value) {
                                        referenceTypeID = snapshot.data
                                            ?.firstWhere(
                                                (item) => item.name == value)
                                            .id;
                                        referenceTypeTitle = value;
                                        return null;
                                      },
                                    );
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  }
                                  return Container();
                                },
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "InActive",
                                style: GoogleFonts.raleway(),
                              ),
                              Checkbox(
                                value: inActive,
                                activeColor: Constants.primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    inActive = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: const BoxDecoration(
                                    color: Constants.primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: GestureDetector(
                                  onTap: () {
                                    _onSubmit();
                                  },
                                  child: Text(
                                    widget.edit == true ? "UPDATE" : "SAVE",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ))
                            ],
                          )
                        ],
                      ),
                    ));
              },
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.edit == true) {
          CommonFunctions.editRecordConfirmDialog(
              context: context,
              ontap: () {
                Navigator.of(context).pop();
                _addReferenceSheet();
              });
        } else {
          _addReferenceSheet();
        }
      },
      child: widget.widget,
    );
  }
}
