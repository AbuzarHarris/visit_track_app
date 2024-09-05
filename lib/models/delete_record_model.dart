// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DeleteRecordModel {
  int userID;
  int companyID;
  int masterID;
  DeleteRecordModel({
    required this.userID,
    required this.companyID,
    required this.masterID,
  });

  DeleteRecordModel copyWith({
    int? userID,
    int? companyID,
    int? masterID,
  }) {
    return DeleteRecordModel(
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

  factory DeleteRecordModel.fromMap(Map<String, dynamic> map) {
    return DeleteRecordModel(
      userID: map['userID'] as int,
      companyID: map['companyID'] as int,
      masterID: map['masterID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeleteRecordModel.fromJson(String source) =>
      DeleteRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DeleteRecordModel(userID: $userID, companyID: $companyID, masterID: $masterID)';

  @override
  bool operator ==(covariant DeleteRecordModel other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.companyID == companyID &&
        other.masterID == masterID;
  }

  @override
  int get hashCode => userID.hashCode ^ companyID.hashCode ^ masterID.hashCode;
}
