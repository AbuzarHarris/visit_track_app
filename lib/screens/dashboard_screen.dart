import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/components/action_buttons_sheet_component.dart';
import 'package:personal_phone_dictionary/components/add_notes_sheet_component.dart';
import 'package:personal_phone_dictionary/components/add_visits_component.dart';
import 'package:personal_phone_dictionary/components/logout_user_componenet.dart';
import 'package:personal_phone_dictionary/components/schedule_visit_sheet_component.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  SecureStorage secureStorage = SecureStorage();

  Future<String> getUserName() async {
    String username = await secureStorage.readSecureData("firstName");
    return username;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getUserName();
  // }

  Widget _userInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "Hello ${snapshot.data}",
                      style: GoogleFonts.raleway(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    );
                  }
                  return Container();
                }),
            Text("Have a nice day!", style: GoogleFonts.raleway(fontSize: 14))
          ],
        ),
        GestureDetector(
          onTap: _logoutUser,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Constants.primaryColor),
            child: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  void _logoutUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LogOutUserComponent();
        });
  }

  Widget _sectionTitle(String title, Widget leadingWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leadingWidget
      ],
    );
  }

  Widget _visitorQuerySection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _visitorQuerySectionCard(),
          const SizedBox(
            width: 10,
          ),
          _visitorQuerySectionCard(),
        ],
      ),
    );
  }

  Widget _visitorQuerySectionCard() {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(25),
          border:
              Border.all(color: const Color.fromRGBO(165, 165, 165, 0.071))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Robert Akintson",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text("Web Developer")
                    ],
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              const Text("2 hrs ago")
            ],
          ),
          const Divider(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                  ),
                  Text(
                    "At 3:00 AM",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _actionsSection() {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/addnewcontact");
          },
          child: _actionsSectionsCard(Colors.green[900]!, "New Client",
              Icons.person_add_alt_rounded, "addnewclient"),
        )),
        Expanded(
            child: AddVisitsComponent(
                widget: _actionsSectionsCard(Colors.blue[900]!, "Add Visit",
                    Icons.person_pin_circle_rounded, "addvisit"))),
        Expanded(
            child: AddNotesSheetComponent(
          widget: _actionsSectionsCard(Colors.yellow[900]!, "Add Notes",
              Icons.add_comment_rounded, "addnotes"),
        )),
        Expanded(
            child: ScheduleVisitSheetComponent(
          widget: _actionsSectionsCard(Colors.red[900]!, "Schedule Visit",
              Icons.schedule_rounded, "schedulevisit"),
        )),
      ],
    );
  }

  Widget _actionsSectionsCard(
      Color color, String title, IconData icon, String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget _visitorStatsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.blue[900], borderRadius: BorderRadius.circular(10)),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "5",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "New Clients",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(height: 40, child: VerticalDivider(color: Colors.white)),
          Expanded(
            child: Column(
              children: [
                Text(
                  "10",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Visits Done",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(height: 40, child: VerticalDivider(color: Colors.white)),
          Expanded(
            child: Column(
              children: [
                Text(
                  "23",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Pending Visits",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
          SizedBox(height: 40, child: VerticalDivider(color: Colors.white)),
          Expanded(
            child: Column(
              children: [
                Text(
                  "67",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "Upcoming Visits",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                _userInfoSection(),
                const SizedBox(
                  height: 15,
                ),
                // _sectionTitle(
                //   "Visitor Stats",
                //   Container(),
                // ),
                const SizedBox(
                  height: 15,
                ),
                _visitorStatsSection(),
                const SizedBox(
                  height: 15,
                ),
                _sectionTitle(
                    "Actions",
                    const ActionButtonsSheetComponent(
                      button: Text(
                        "View More",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    )
                    // GestureDetector(
                    //   onTap: () {

                    //   },
                    //   child: const Text(
                    //     "View More",
                    //     style: TextStyle(fontWeight: FontWeight.w400),
                    //   ),
                    // ),
                    ),
                const SizedBox(
                  height: 15,
                ),
                _actionsSection(),
                const SizedBox(
                  height: 15,
                ),
                _sectionTitle(
                  "Visitors Query",
                  const Text(
                    "View More",
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _visitorQuerySection(),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
