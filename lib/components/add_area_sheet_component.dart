import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/area_apis.dart';
import 'package:personal_phone_dictionary/components/form_input_component.dart';
import 'package:personal_phone_dictionary/components/toasts.dart';
import 'package:personal_phone_dictionary/models/area_list_model.dart';
import 'package:personal_phone_dictionary/utils/common.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

class AddAreaSheetComponent extends StatefulWidget {
  final Widget widget;
  final AreaListModel? areaListModel;
  final bool edit;
  const AddAreaSheetComponent(
      {super.key, required this.widget, this.areaListModel, this.edit = false});

  @override
  State<AddAreaSheetComponent> createState() => _AddAreaSheetComponentState();
}

class _AddAreaSheetComponentState extends State<AddAreaSheetComponent> {
  final TextEditingController _areaTitleController = TextEditingController();
  int areaID = 0;
  bool? inActive = false;
  Future<void> onsubmit() async {
    SecureStorage secureStorage = SecureStorage();
    String userID = await secureStorage.readSecureData("userID");
    String companyID = await secureStorage.readSecureData("companyID");

    AreaListModel model = AreaListModel(
        companyID: int.parse(companyID),
        userID: int.parse(userID),
        areaID: areaID,
        areaTitle: _areaTitleController.text,
        inActive: inActive ?? false,
        entryDate: DateTime.now().toString());
    String msg = "";
    try {
      msg = await areaInsertUpdate(model);
      if (msg == "") {
        if (mounted) {
          ToastUtils.showOkToast(
              context: context,
              message: "Record Saved Successfully!",
              icon: const Icon(Icons.check));
          _clearValues();
          Navigator.of(context).pop();
          if (widget.edit == true) {
            Navigator.of(context).pushNamed("/arealist");
          }
        }
      } else {
        if (mounted) {
          ToastUtils.showErrorToast(
              context: context, message: msg, icon: const Icon(Icons.error));
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
    areaID = 0;
    _areaTitleController.text = "";
    inActive = false;
  }

  void _addAreaSheet() {
    if (widget.areaListModel != null) {
      _areaTitleController.text = widget.areaListModel!.areaTitle;
      areaID = widget.areaListModel!.areaID;
      inActive = widget.areaListModel!.inActive;
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
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 0.6,
              shouldCloseOnMinExtent: false,
              expand: false,
              builder: (context, controller) {
                return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.edit == true ? "Edit Area" : "Add Area",
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
                                  controller: _areaTitleController,
                                  autofocus: true,
                                  hintText: "Title",
                                  keyboardType: TextInputType.text,
                                ),
                              ),
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
                                    onsubmit();
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
                _addAreaSheet();
              });
        } else {
          _addAreaSheet();
        }
      },
      child: widget.widget,
    );
  }
}
