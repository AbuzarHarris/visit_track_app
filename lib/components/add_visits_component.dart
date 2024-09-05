import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/components/date_picker_component.dart';
import 'package:personal_phone_dictionary/components/multiple_dropdown_component.dart';
import 'package:personal_phone_dictionary/components/single_dropdown_component.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class AddVisitsComponent extends StatefulWidget {
  final Widget widget;

  const AddVisitsComponent({super.key, required this.widget});

  @override
  State<AddVisitsComponent> createState() => _AddVisitsComponentState();
}

class _AddVisitsComponentState extends State<AddVisitsComponent> {
  DateTime visitDate = DateTime.now();
  DateTime? nextVisitDate;
  List<String>? visitedBy;
  String? visitTo;

  void _addNewVisitSheet() {
    nextVisitDate = null;
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
                        "Add Visit",
                        style: GoogleFonts.raleway(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DatePickerComponent(
                              hintText: "Visit Date",
                              inputdate: visitDate,
                              onDateSelected: (value) {
                                visitDate = value;
                              },
                              showsuffix: false,
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
                            child: SingleDropdownComponent(
                              labelText: "Visit To",
                              items: const ["Huzaifa", "Sajid", "Abc"],
                              showSearchBox: true,
                              onChange: (value) {
                                visitTo = value;
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
                            child: MultipleDropdownComponent(
                              labelText: "Visited By",
                              items: const ["Huzaifa", "Sajid", "Abc"],
                              showSearchBox: true,
                              onChange: (value) {
                                visitedBy = value;
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
                            child: DatePickerComponent(
                              hintText: "Next Visit Date",
                              inputdate: nextVisitDate,
                              onDateSelected: (value) {
                                nextVisitDate = value;
                              },
                              showsuffix: true,
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
        _addNewVisitSheet();
      },
      child: widget.widget,
    );
  }
}
