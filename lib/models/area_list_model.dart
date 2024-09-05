import 'dart:convert';

class AreaListModel {
  int companyID;
  int userID;
  int areaID;
  String areaTitle;
  bool inActive;
  AreaListModel({
    required this.companyID,
    required this.userID,
    required this.areaID,
    required this.areaTitle,
    required this.inActive,
  });

  AreaListModel copyWith({
    int? companyID,
    int? userID,
    int? areaID,
    String? areaTitle,
    bool? inActive,
  }) {
    return AreaListModel(
      companyID: companyID ?? this.companyID,
      userID: userID ?? this.userID,
      areaID: areaID ?? this.areaID,
      areaTitle: areaTitle ?? this.areaTitle,
      inActive: inActive ?? this.inActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyID': companyID,
      'userID': userID,
      'areaID': areaID,
      'areaTitle': areaTitle,
      'inActive': inActive,
    };
  }

  factory AreaListModel.fromMap(Map<String, dynamic> map) {
    return AreaListModel(
      companyID: map['companyID'] as int,
      userID: map['userID'] as int,
      areaID: map['areaID'] as int,
      areaTitle: map['areaTitle'] as String,
      inActive: map['inActive'] as bool,
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
