import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/components/date_picker_component.dart';
import 'package:personal_phone_dictionary/components/single_dropdown_component.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class ScheduleVisitSheetComponent extends StatefulWidget {
  final Widget widget;

  const ScheduleVisitSheetComponent({super.key, required this.widget});

  @override
  State<ScheduleVisitSheetComponent> createState() =>
      _ScheduleVisitSheetComponentState();
}

class _ScheduleVisitSheetComponentState
    extends State<ScheduleVisitSheetComponent> {
  String? scheduleVisitClient;
  DateTime? scheduleVisitDate;
  void _scheduleVisitSheet() {
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
          initialChildSize: 0.4,
          maxChildSize: 0.4,
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
                        "Schedule Visit",
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
                              selectedItem: scheduleVisitClient,
                              onChange: (value) {
                                scheduleVisitClient = value;
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
                              hintText: "Date",
                              inputdate: scheduleVisitDate,
                              onDateSelected: (value) {
                                scheduleVisitDate = value;
                              },
                              showsuffix: false,
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
        _scheduleVisitSheet();
      },
      child: widget.widget,
    );
  }
}
