class ReferenceTypeDropdownModel {
  String id;
  String name;

  ReferenceTypeDropdownModel({required this.id, required this.name});

  factory ReferenceTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    return ReferenceTypeDropdownModel(
      id: json["ReferenceTypeID"].toString(),
      name: json["ReferenceTypeTitle"].toString(),
    );
  }

  static List<ReferenceTypeDropdownModel> fromJsonList(List list) {
    return list
        .map((item) => ReferenceTypeDropdownModel.fromJson(item))
        .toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(ReferenceTypeDropdownModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}

class ReferencesDropdownModel {
  String id;
  String name;

  ReferencesDropdownModel({required this.id, required this.name});

  factory ReferencesDropdownModel.fromJson(Map<String, dynamic> json) {
    return ReferencesDropdownModel(
      id: json["ReferenceID"].toString(),
      name: json["ReferenceTitle"].toString(),
    );
  }

  static List<ReferencesDropdownModel> fromJsonList(List list) {
    return list.map((item) => ReferencesDropdownModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(ReferencesDropdownModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}

class AreaDropdownModel {
  String id;
  String name;

  AreaDropdownModel({required this.id, required this.name});

  factory AreaDropdownModel.fromJson(Map<String, dynamic> json) {
    return AreaDropdownModel(
      id: json["AreaID"].toString(),
      name: json["AreaTitle"].toString(),
    );
  }

  static List<AreaDropdownModel> fromJsonList(List list) {
    return list.map((item) => AreaDropdownModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(AreaDropdownModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
