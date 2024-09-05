import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/components/add_area_sheet_component.dart';
import 'package:personal_phone_dictionary/components/add_notes_sheet_component.dart';
import 'package:personal_phone_dictionary/components/add_reference_sheet_component.dart';
import 'package:personal_phone_dictionary/components/add_referencetype_sheet_componenet.dart';
import 'package:personal_phone_dictionary/components/add_user_component.dart';
import 'package:personal_phone_dictionary/components/add_visits_component.dart';
import 'package:personal_phone_dictionary/components/bottom_navigation_bar.dart';
import 'package:personal_phone_dictionary/components/schedule_visit_sheet_component.dart';
import 'package:personal_phone_dictionary/components/text_input_component.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class ActionButtonsSheetComponent extends StatefulWidget {
  final Widget button;
  const ActionButtonsSheetComponent({super.key, required this.button});

  @override
  State<ActionButtonsSheetComponent> createState() =>
      _ActionButtonsSheetComponentState();
}

class _ActionButtonsSheetComponentState
    extends State<ActionButtonsSheetComponent> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> items = [
    {
      "title": "View Clients",
      "icon": Icons.supervised_user_circle_rounded,
      "type": "viewclients",
    },
    {
      "title": "View Visits",
      "icon": Icons.edit_location_rounded,
      "type": "viewvisits",
    },
    {
      "title": "View Notes",
      "icon": Icons.view_headline_rounded,
      "type": "viewnotes",
    },
    {
      "title": "Add Reference Type",
      "icon": Icons.playlist_add_circle_rounded,
      "type": "addreferencetype",
    },
    {
      "title": "Add References",
      "icon": Icons.add_circle_rounded,
      "type": "addreference",
    },
    {
      "title": "Add Area",
      "icon": Icons.add_location_alt,
      "type": "addarea",
    },
    {
      "title": "Add Users",
      "icon": Icons.person_add_alt_1,
      "type": "adduser",
    },
    {
      "title": "New Client",
      "icon": Icons.person_add_alt_1_rounded,
      "type": "addnewclient",
    },
    {
      "title": "Add Visit",
      "icon": Icons.person_pin_circle_rounded,
      "type": "addvisit",
    },
    {
      "title": "Add Notes",
      "icon": Icons.note_add_sharp,
      "type": "addnotes",
    },
    {
      "title": "Schedule Visit",
      "icon": Icons.person_add_alt_1_rounded,
      "type": "schedulevisit",
    },
    {
      "title": "Users",
      "icon": Icons.account_circle_rounded,
      "type": "viewusers",
    },
    {
      "title": "Settings",
      "icon": Icons.settings,
      "type": "settings",
    },
    {
      "title": "Area List",
      "icon": Icons.location_city_rounded,
      "type": "arealist",
    },
  ];
  List<Map<String, dynamic>> filteredItems = [];
  @override
  void initState() {
    setState(() {
      filteredItems = items;
    });
    super.initState();
  }

// String searchquery = "";
//     List<Map<String, dynamic>> onSearchInput(List<Map<String, dynamic>> data) {
//       print("called");
//       if (searchquery.isEmpty) {
//         return data;
//       } else {
//         return data.where((element) {
//           final name = element["title"].toString().toLowerCase();
//           // final invoiceno = element.sessionBasedVoucherNo.toString();
//           final query = searchquery.toLowerCase();

//           return name.contains(query);
//         }).toList();
//       }
//       // String searchText = value.toLowerCase();

//       // setState(() {
//       //   _filteredItems = items
//       //       .where((item) =>
//       //           item['title'].toString().toLowerCase().contains(searchText))
//       //       .toList();
//       // });
//     }

  void showSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,

      isScrollControlled: true,
      clipBehavior: Clip.antiAlias, // default is Clip.none
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          builder: (_, controller) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _searchController,
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              filteredItems = items
                                  .where((item) => item["title"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                                  .toList();
                            });
                          },
                          decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              isDense: true,
                              floatingLabelStyle: GoogleFonts.raleway(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  letterSpacing: 1),
                              labelStyle: GoogleFonts.raleway(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  letterSpacing: 1),
                              suffixIcon: const Icon(
                                Icons.search_rounded,
                                color: Colors.grey,
                                size: 15,
                              ),
                              hintStyle: GoogleFonts.raleway(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  letterSpacing: 1),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 5.0,
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Constants.textinputColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25))),
                              hintText: "Search"),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: filteredItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            if (filteredItems[index]["type"] == "viewclients") {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomBottomNavigationBar(
                                        index: 1,
                                      ),
                                    ),
                                  );
                                },
                                child: _moreSectionsCard(
                                    Colors.transparent,
                                    filteredItems[index]["title"],
                                    filteredItems[index]["icon"],
                                    filteredItems[index]["type"]),
                              );
                            } else if (items[index]["type"] == "viewvisits") {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomBottomNavigationBar(
                                        index: 2,
                                      ),
                                    ),
                                  );
                                },
                                child: _moreSectionsCard(
                                    Colors.transparent,
                                    filteredItems[index]["title"],
                                    filteredItems[index]["icon"],
                                    filteredItems[index]["type"]),
                              );
                            } else if (filteredItems[index]["type"] ==
                                "viewnotes") {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomBottomNavigationBar(
                                        index: 3,
                                      ),
                                    ),
                                  );
                                },
                                child: _moreSectionsCard(
                                    Colors.transparent,
                                    filteredItems[index]["title"],
                                    filteredItems[index]["icon"],
                                    filteredItems[index]["type"]),
                              );
                            } else if (filteredItems[index]["type"] ==
                                "addreference") {
                              return Expanded(
                                  child: AddReferenceSheetComponent(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "addarea") {
                              return Expanded(
                                  child: AddAreaSheetComponent(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "adduser") {
                              return Expanded(
                                  child: AddUserSheetComponent(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "addnewclient") {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed("/addnewcontact");
                                },
                                child: _moreSectionsCard(
                                    Colors.transparent,
                                    filteredItems[index]["title"],
                                    filteredItems[index]["icon"],
                                    filteredItems[index]["type"]),
                              );
                            } else if (filteredItems[index]["type"] ==
                                "addvisit") {
                              return Expanded(
                                  child: AddVisitsComponent(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "arealist") {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed("/arealist");
                                },
                                child: _moreSectionsCard(
                                    Colors.transparent,
                                    filteredItems[index]["title"],
                                    filteredItems[index]["icon"],
                                    filteredItems[index]["type"]),
                              );
                            } else if (filteredItems[index]["type"] ==
                                "addnotes") {
                              return Expanded(
                                  child: AddNotesSheetComponent(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "schedulevisit") {
                              return Expanded(
                                  child: ScheduleVisitSheetComponent(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "viewusers") {
                              return Expanded(
                                  child: AddVisitsComponent(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "addreferencetype") {
                              return Expanded(
                                  child: AddReferencetypeSheetComponenet(
                                      widget: _moreSectionsCard(
                                          Colors.transparent,
                                          filteredItems[index]["title"],
                                          filteredItems[index]["icon"],
                                          filteredItems[index]["type"])));
                            } else if (filteredItems[index]["type"] ==
                                "settings") {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomBottomNavigationBar(
                                        index: 4,
                                      ),
                                    ),
                                  );
                                },
                                child: _moreSectionsCard(
                                    Colors.transparent,
                                    filteredItems[index]["title"],
                                    filteredItems[index]["icon"],
                                    filteredItems[index]["type"]),
                              );
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ));
            });
          },
        );
      },
    );
  }

  Widget _moreSectionsCard(
      Color color, String title, IconData icon, String type) {
    return Expanded(
      child: Column(children: [
        Icon(
          icon,
          color: Constants.primaryColor,
          size: 25,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
              fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSheet();
      },
      child: widget.button,
    );
  }
}
