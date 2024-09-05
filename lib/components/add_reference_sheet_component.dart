import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/references_api.dart';
import 'package:personal_phone_dictionary/components/form_input_component.dart';
import 'package:personal_phone_dictionary/components/single_dropdown_component.dart';
import 'package:personal_phone_dictionary/models/reference_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

class AddReferenceSheetComponent extends StatefulWidget {
  final Widget widget;
  final ReferenceModel? referenceModel;
  const AddReferenceSheetComponent(
      {super.key, required this.widget, this.referenceModel});

  @override
  State<AddReferenceSheetComponent> createState() =>
      _AddReferenceSheetComponentState();
}

class _AddReferenceSheetComponentState
    extends State<AddReferenceSheetComponent> {
  final TextEditingController _referenceNameController =
      TextEditingController();
  String referenceType = "";

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
          referenceTypeID: int.parse(referenceType),
          referenceTitle: _referenceNameController.text,
          inActive: false);

      var apiResponse = await insertUpdateReferenceAsync(model);

      if (apiResponse.success) {
        //TODO Show Success Toast
      }
    } catch (e) {
      //TODO Show Error Toast
      throw Exception(e);
    }
  }

  void _addReferenceSheet() {
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
                        "Add Reference",
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
                            child: Expanded(
                              child: SingleDropdownComponent(
                                labelText: "Reference Type",
                                items: const ["Internal", "External"],
                                showSearchBox: false,
                                onChange: (value) {
                                  referenceType = value.toString();
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                              child: Text(
                                "SAVE",
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _addReferenceSheet,
      child: widget.widget,
    );
  }
}
