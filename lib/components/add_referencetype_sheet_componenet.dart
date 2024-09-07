import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/reference_types_api.dart';
import 'package:personal_phone_dictionary/components/form_input_component.dart';
import 'package:personal_phone_dictionary/components/toasts.dart';
import 'package:personal_phone_dictionary/models/reference_type_model.dart';
import 'package:personal_phone_dictionary/utils/common.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

class AddReferencetypeSheetComponenet extends StatefulWidget {
  final Widget widget;
  final ReferenceTypeModel? referenceTypeModel;
  final bool edit;
  const AddReferencetypeSheetComponenet(
      {super.key,
      required this.widget,
      this.referenceTypeModel,
      this.edit = false});

  @override
  State<AddReferencetypeSheetComponenet> createState() =>
      _AddReferencetypeSheetComponenetState();
}

class _AddReferencetypeSheetComponenetState
    extends State<AddReferencetypeSheetComponenet> {
  final TextEditingController _referenceTypeTitleController =
      TextEditingController();
  int referenceTypeID = 0;
  bool? inActive = false;

  Future<void> _onSubmit() async {
    try {
      SecureStorage secureStorage = SecureStorage();
      String userID = await secureStorage.readSecureData("userID");
      String companyID = await secureStorage.readSecureData("companyID");

      ReferenceTypeModel model = ReferenceTypeModel(
          companyID: int.parse(userID),
          userID: int.parse(companyID),
          referenceTypeTitle: _referenceTypeTitleController.text,
          referenceTypeID: widget.referenceTypeModel != null
              ? widget.referenceTypeModel!.referenceTypeID
              : 0,
          inActive: inActive ?? false,
          entryDate: DateTime.now().toString());

      var apiResponse = await insertUpdateReferenceTypeAsync(model);

      if (apiResponse.success) {
        if (mounted) {
          ToastUtils.showOkToast(
              context: context,
              message: "Record Saved Successfully!",
              icon: const Icon(Icons.check));
          _clearValues();
          Navigator.of(context).pop();
          if (widget.edit == true) {
            Navigator.of(context).pushNamed("/referencetypelist");
          }
        }
      } else {
        if (mounted) {
          ToastUtils.showErrorToast(
              context: context,
              message: apiResponse.message.toString(),
              icon: const Icon(Icons.error));
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
    referenceTypeID = 0;
    _referenceTypeTitleController.text = "";
    inActive = false;
  }

  void _addReferenceTypeSheet() {
    if (widget.referenceTypeModel != null) {
      _referenceTypeTitleController.text =
          widget.referenceTypeModel!.referenceTypeTitle;
      referenceTypeID = widget.referenceTypeModel!.referenceTypeID;
      inActive = widget.referenceTypeModel!.inActive;
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
              initialChildSize: 0.6,
              maxChildSize: 0.6,
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
                                ? "Edit Reference Type"
                                : "Add Reference Type",
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
                                  controller: _referenceTypeTitleController,
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
                                  onTap: _onSubmit,
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
                _addReferenceTypeSheet();
              });
        } else {
          _addReferenceTypeSheet();
        }
      },
      child: widget.widget,
    );
  }
}
