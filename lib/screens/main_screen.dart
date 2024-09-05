import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/components/logout_user_componenet.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget cardTile(String title, IconData icon, String routeUrl, Color color,
      String imagePath) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeUrl);
        },
        child: Column(
          children: [
            Container(
                width: 80,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Icon(icon)),
            const SizedBox(
              height: 3,
            ),
            Text(title,
                style: GoogleFonts.montserrat(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _logoutUser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LogOutUserComponent();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 243, 243, 243)),
      child: PopScope(
        canPop: false,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Edu',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Dictionary',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              centerTitle: true,
              backgroundColor: Constants.primaryColor,
              actions: [
                GestureDetector(
                  onTap: _logoutUser,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Icon(
                        size: 22,
                        weight: 1,
                        color: Color.fromARGB(255, 255, 255, 255),
                        Icons.logout_rounded),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    decoration:
                        const BoxDecoration(color: Constants.primaryColor),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 5, 12, 12),
                      child: Container(
                        height: 130,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 216, 216, 216),
                                  blurRadius: 5,
                                  // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/addnewcontact");
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                  size: 22,
                                                  weight: 1,
                                                  color: Constants.primaryColor,
                                                  Icons.add_call),
                                            ),
                                          ),
                                          Text("New Contact",
                                              style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    )),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 216, 216, 216),
                                  blurRadius: 5,
                                  // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/addnewcontact");
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                  size: 22,
                                                  weight: 1,
                                                  color: Constants.primaryColor,
                                                  Icons
                                                      .add_location_alt_rounded),
                                            ),
                                          ),
                                          Text("Add Visit",
                                              style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    )),
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 216, 216, 216),
                                  blurRadius: 5,
                                  // Shadow position
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/addnewcontact");
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                  size: 22,
                                                  color: Constants.primaryColor,
                                                  Icons.person_search_rounded),
                                            ),
                                          ),
                                          Text("Search",
                                              style: GoogleFonts.rubik(
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    )),
                              ],
                            )),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Container(
                  //       height: 80,
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           GestureDetector(
                  //               onTap: () {
                  //                 Navigator.pushNamed(context, "/addnewcontact");
                  //               },
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     padding: const EdgeInsets.all(15),
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(10),
                  //                       color: Colors.white.withOpacity(0.2),
                  //                     ),
                  //                     child: const Center(
                  //                       child: Icon(
                  //                           size: 20,
                  //                           color: Constants.primaryColor,
                  //                           Icons.contact_phone_outlined),
                  //                     ),
                  //                   ),
                  //                   Text("New Contact",
                  //                       style: GoogleFonts.montserrat(
                  //                           color: Colors.amber, fontSize: 14)),
                  //                 ],
                  //               )),
                  //           const VerticalDivider(
                  //             color: Colors.black,
                  //             thickness: 0.5,
                  //             endIndent: 10,
                  //             indent: 10,
                  //           ),
                  //           GestureDetector(
                  //               onTap: () {
                  //                 Navigator.pushNamed(context, "/addnewcontact");
                  //               },
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     padding: const EdgeInsets.all(15),
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(10),
                  //                       color: Colors.white.withOpacity(0.2),
                  //                     ),
                  //                     child: const Center(
                  //                       child: Icon(
                  //                           size: 20,
                  //                           Icons.contact_emergency_outlined),
                  //                     ),
                  //                   ),
                  //                   Text("View Contacts",
                  //                       style: GoogleFonts.montserrat(
                  //                           color: Colors.amber, fontSize: 14)),
                  //                 ],
                  //               )),
                  //           const VerticalDivider(
                  //             color: Colors.black,
                  //             thickness: 0.5,
                  //             endIndent: 10,
                  //             indent: 10,
                  //           ),
                  //           GestureDetector(
                  //               onTap: () {
                  //                 Navigator.pushNamed(context, "/addnewcontact");
                  //               },
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     padding: const EdgeInsets.all(15),
                  //                     decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(10),
                  //                       color: Colors.white.withOpacity(0.2),
                  //                     ),
                  //                     child: const Center(
                  //                       child: Icon(size: 20, Icons.person_2),
                  //                     ),
                  //                   ),
                  //                   Text("Add Visit",
                  //                       style: GoogleFonts.montserrat(
                  //                           color: Colors.amber, fontSize: 14)),
                  //                 ],
                  //               )),
                  //         ],
                  //       )),
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
