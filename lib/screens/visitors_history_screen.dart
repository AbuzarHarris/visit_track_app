import 'package:flutter/material.dart';

class VisitorsHistoryScreen extends StatefulWidget {
  const VisitorsHistoryScreen({super.key});

  @override
  State<VisitorsHistoryScreen> createState() => _VisitorsHistoryScreenState();
}

class _VisitorsHistoryScreenState extends State<VisitorsHistoryScreen> {
  final filtrationItems = ["All", "Accepted", "Rejected"];
  int _selectedFiltraionIndex = 0;

  Widget appBarSection() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.horizontal_rule,
          size: 30,
        ),
        Text(
          "History",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.search,
          size: 30,
        ),
      ],
    );
  }

  Widget _filtrationSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _filtrationSectionItem(0, filtrationItems[0]),
        const SizedBox(
          width: 10,
        ),
        _filtrationSectionItem(1, filtrationItems[1]),
        const SizedBox(
          width: 10,
        ),
        _filtrationSectionItem(2, filtrationItems[2]),
      ],
    );
  }

  Widget _filtrationSectionItem(int index, String title) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        setState(() {
          _selectedFiltraionIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: _selectedFiltraionIndex == index
                ? Colors.blue[900]
                : const Color.fromRGBO(247, 248, 253, 1),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: _selectedFiltraionIndex == index
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    ));
  }

  Widget _visitorQuerySection() {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return _visitorQuerySectionCard();
      },
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 15,
        );
      },
    );
  }

  Widget _visitorQuerySectionCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 248, 253, 1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
            appBarSection(),
            const SizedBox(
              height: 20,
            ),
            _filtrationSection(),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: _visitorQuerySection())
          ],
        ),
      )),
    );
  }
}
