import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/api/reference_types_api.dart';
import 'package:personal_phone_dictionary/components/form_input_component.dart';
import 'package:personal_phone_dictionary/models/reference_type_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

class AddReferencetypeSheetComponenet extends StatefulWidget {
  final Widget widget;
  final ReferenceTypeModel? referenceTypeModel;
  const AddReferencetypeSheetComponenet(
      {super.key, required this.widget, this.referenceTypeModel});

  @override
  State<AddReferencetypeSheetComponenet> createState() =>
      _AddReferencetypeSheetComponenetState();
}

class _AddReferencetypeSheetComponenetState
    extends State<AddReferencetypeSheetComponenet> {
  final TextEditingController _referenceTypeTitleController =
      TextEditingController();

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
          inActive: false);

      var apiResponse = await insertUpdateReferenceTypeAsync(model);

      if (apiResponse.success) {
        //TODO Show Success Toast
      }
    } catch (e) {
      //TODO Show Error Toast
      throw Exception(e);
    }
  }

  void _addReferenceTypeSheet() {
    if (widget.referenceTypeModel != null) {
      _referenceTypeTitleController.text =
          widget.referenceTypeModel!.referenceTypeTitle;
    }

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
                        "Add Reference Type",
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
                              onTap: _onSubmit,
                              child: Text(
                                widget.referenceTypeModel != null
                                    ? "SAVE"
                                    : "UPDATE",
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
      onTap: _addReferenceTypeSheet,
      child: widget.widget,
    );
  }
}
