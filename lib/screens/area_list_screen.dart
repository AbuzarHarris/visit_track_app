import 'package:flutter/material.dart';
import 'package:personal_phone_dictionary/components/add_area_sheet_component.dart';
import 'package:personal_phone_dictionary/components/filtration_appbar_component.dart';
import 'package:personal_phone_dictionary/models/area_list_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class AreaListScreen extends StatefulWidget {
  const AreaListScreen({super.key});

  @override
  State<AreaListScreen> createState() => _AreaListScreenState();
}

class _AreaListScreenState extends State<AreaListScreen> {
  final filtrationItems = ["All", "Active", "In Active"];

  int _selectedFiltraionIndex = 0;

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

  Widget addressListItem(AreaListModel model) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [],
        color: const Color.fromRGBO(247, 248, 253, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              "Multan skdfjsdfklg sd fgsdfgjlsdk fgsdf ghklsdfkg sdf sdfkl gsdfgl sdflk ghsdfl gsdlfk ghsdfkl ghsdf gsdfhlg lsdf"),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AddAreaSheetComponent(
                areaListModel: model,
                widget: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<List<AreaListModel>> getAreas() async {
    List<AreaListModel> areas = [
      AreaListModel(
          companyID: 1,
          userID: 1,
          areaID: 1,
          areaTitle: "Multan",
          inActive: true),
      AreaListModel(
          companyID: 1,
          userID: 1,
          areaID: 1,
          areaTitle: "Multan",
          inActive: false),
      AreaListModel(
          companyID: 1,
          userID: 1,
          areaID: 1,
          areaTitle: "Multan",
          inActive: true),
      AreaListModel(
          companyID: 1,
          userID: 1,
          areaID: 1,
          areaTitle: "Multan",
          inActive: false),
      AreaListModel(
          companyID: 1,
          userID: 1,
          areaID: 1,
          areaTitle: "Multan",
          inActive: false),
      AreaListModel(
          companyID: 1,
          userID: 1,
          areaID: 1,
          areaTitle: "Multan",
          inActive: false),
    ];

    return areas;
  }

  List<AreaListModel> _getFilteredData(List<AreaListModel> data) {
    if (_selectedFiltraionIndex == 0) {
      return data;
    } else if (_selectedFiltraionIndex == 1) {
      return data.where((item) {
        return item.inActive == true;
      }).toList();
    } else {
      return data.where((item) {
        return item.inActive == false;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          children: [
            const FiltrationAppbarComponent(
              title: "Addresses",
            ),
            const SizedBox(
              height: 20,
            ),
            _filtrationSection(),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getAreas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "No products found!",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed("/dashboard");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Constants.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  "Go Back",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      var data = snapshot.data!;

                      var filteredData = _getFilteredData(data);

                      return RefreshIndicator(
                        onRefresh: getAreas,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: filteredData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return addressListItem(filteredData[index]);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      )),
    );
  }
}
