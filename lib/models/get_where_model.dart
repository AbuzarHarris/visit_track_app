// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetWhereModel {
  int userID;
  int companyID;
  int masterID;
  GetWhereModel({
    required this.userID,
    required this.companyID,
    required this.masterID,
  });

  GetWhereModel copyWith({
    int? userID,
    int? companyID,
    int? masterID,
  }) {
    return GetWhereModel(
      userID: userID ?? this.userID,
      companyID: companyID ?? this.companyID,
      masterID: masterID ?? this.masterID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'companyID': companyID,
      'masterID': masterID,
    };
  }

  factory GetWhereModel.fromMap(Map<String, dynamic> map) {
    return GetWhereModel(
      userID: map['userID'] as int,
      companyID: map['companyID'] as int,
      masterID: map['masterID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetWhereModel.fromJson(String source) =>
      GetWhereModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'GetWhereModel(userID: $userID, companyID: $companyID, masterID: $masterID)';

  @override
  bool operator ==(covariant GetWhereModel other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.companyID == companyID &&
        other.masterID == masterID;
  }

  @override
  int get hashCode => userID.hashCode ^ companyID.hashCode ^ masterID.hashCode;
}
