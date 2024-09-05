import 'package:flutter/material.dart';
import 'package:personal_phone_dictionary/screens/dashboard_screen.dart';
import 'package:personal_phone_dictionary/screens/visitors_history_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  int? index;
  CustomBottomNavigationBar({super.key, this.index});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 0;
  }

  final List<Widget> screens = [
    const DashboardScreen(),
    const VisitorsHistoryScreen(),
    const Text("Screen 3"),
    const Text("Screen 4"),
    const Text("Screen 5"),
  ];

  void changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem bottomNavigationBarItem(
      int index, IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        key: const ValueKey<int>(-1),
      ),
      activeIcon: Icon(
        icon,
        color: Colors.blue[900],
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      minimum: const EdgeInsets.only(top: 20),
      child: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.grey[300],
            showUnselectedLabels: false,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: changeScreen,
            mouseCursor: SystemMouseCursors.click,
            items: [
              bottomNavigationBarItem(0, Icons.home_filled, "Home"),
              bottomNavigationBarItem(
                  1, Icons.supervised_user_circle_rounded, "Clients"),
              bottomNavigationBarItem(2, Icons.location_history, "Visits"),
              bottomNavigationBarItem(3, Icons.notes_rounded, "Notes"),
              bottomNavigationBarItem(4, Icons.settings, "Setting"),
            ],
          ),
        ),
      ),
    );
  }
}

/*
BottomNavigationBarItem bottomNavigationBarItem(
    int index, IconData icon, String label) {
  return BottomNavigationBarItem(
    icon: AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _selectedIndex == index
          ? Container(
              key: ValueKey<int>(_selectedIndex),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.blue[900],
                    ),
                    const Spacer(), // Adds flexible space
                    Text(
                      label,
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          : Icon(
              icon,
              key: const ValueKey<int>(-1),
            ),
    ),
    label: "",
  );
}

*/