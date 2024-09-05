import 'dart:convert';

class AreaListModel {
  int companyID;
  int userID;
  int areaID;
  String areaTitle;
  bool inActive;
  String entryDate;
  AreaListModel({
    required this.companyID,
    required this.userID,
    required this.areaID,
    required this.areaTitle,
    required this.inActive,
    required this.entryDate,
  });

  AreaListModel copyWith({
    int? companyID,
    int? userID,
    int? areaID,
    String? areaTitle,
    bool? inActive,
    String? entryDate,
  }) {
    return AreaListModel(
        companyID: companyID ?? this.companyID,
        userID: userID ?? this.userID,
        areaID: areaID ?? this.areaID,
        areaTitle: areaTitle ?? this.areaTitle,
        inActive: inActive ?? this.inActive,
        entryDate: entryDate ?? this.entryDate);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CompanyID': companyID,
      'UserID': userID,
      'AreaID': areaID,
      'AreaTitle': areaTitle,
      'InActive': inActive,
      'EntryDate': entryDate,
    };
  }

  factory AreaListModel.fromMap(Map<String, dynamic> map) {
    return AreaListModel(
      companyID: map['CompanyID'] as int,
      userID: map['UserID'] as int,
      areaID: map['AreaID'] as int,
      areaTitle: map['AreaTitle'] as String,
      inActive: map['InActive'] as bool,
      entryDate: map['EntryDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaListModel.fromJson(String source) =>
      AreaListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AreaListModel(companyID: $companyID, userID: $userID, areaID: $areaID, areaTitle: $areaTitle, inActive: $inActive)';
  }

  @override
  bool operator ==(covariant AreaListModel other) {
    if (identical(this, other)) return true;

    return other.companyID == companyID &&
        other.userID == userID &&
        other.areaID == areaID &&
        other.areaTitle == areaTitle &&
        other.inActive == inActive;
  }

  @override
  int get hashCode {
    return companyID.hashCode ^
        userID.hashCode ^
        areaID.hashCode ^
        areaTitle.hashCode ^
        inActive.hashCode;
  }
}
