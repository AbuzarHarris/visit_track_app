import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/components/single_dropdown_component.dart';
import 'package:personal_phone_dictionary/components/text_area_componenet.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class AddNotesSheetComponent extends StatefulWidget {
  final Widget widget;
  const AddNotesSheetComponent({super.key, required this.widget});

  @override
  State<AddNotesSheetComponent> createState() => _AddNotesSheetComponentState();
}

class _AddNotesSheetComponentState extends State<AddNotesSheetComponent> {
  String? noteForClient;
  final TextEditingController _notesDescriptionController =
      TextEditingController();

  void _addNotesSheet() {
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
                        "Add Notes",
                        style: GoogleFonts.raleway(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SingleDropdownComponent(
                              labelText: "Client",
                              items: const ["Huzaifa", "Sajid", "Abc"],
                              showSearchBox: true,
                              selectedItem: noteForClient,
                              onChange: (value) {
                                noteForClient = value;
                                return null;
                              },
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
                            child: FormTextAreaComponent(
                              controller: _notesDescriptionController,
                              autofocus: false,
                              hintText: "Notes",
                              minLines: 4,
                              maxLines: 6,
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
      onTap: () {
        _addNotesSheet();
      },
      child: widget.widget,
    );
  }
}
