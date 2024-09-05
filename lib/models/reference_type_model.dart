// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReferenceTypeModel {
  int companyID;
  int userID;
  String referenceTypeTitle;
  int referenceTypeID;
  bool inActive;
  ReferenceTypeModel({
    required this.companyID,
    required this.userID,
    required this.referenceTypeTitle,
    required this.referenceTypeID,
    required this.inActive,
  });

  ReferenceTypeModel copyWith({
    int? companyID,
    int? userID,
    int? referenceID,
    String? referenceTypeTitle,
    int? referenceTypeID,
    bool? inActive,
  }) {
    return ReferenceTypeModel(
      companyID: companyID ?? this.companyID,
      userID: userID ?? this.userID,
      referenceTypeTitle: referenceTypeTitle ?? this.referenceTypeTitle,
      referenceTypeID: referenceTypeID ?? this.referenceTypeID,
      inActive: inActive ?? this.inActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CompanyID': companyID,
      'UserID': userID,
      'ReferenceTypeTitle': referenceTypeTitle,
      'ReferenceTypeID': referenceTypeID,
      'InActive': inActive,
    };
  }

  factory ReferenceTypeModel.fromMap(Map<String, dynamic> map) {
    return ReferenceTypeModel(
      companyID: map['CompanyID'] as int,
      userID: map['UserID'] as int,
      referenceTypeTitle: map['ReferenceTypeTitle'] as String,
      referenceTypeID: map['ReferenceTypeID'] as int,
      inActive: map['InActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferenceTypeModel.fromJson(String source) =>
      ReferenceTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReferenceTypeModel(companyID: $companyID, userID: $userID, referenceTypeTitle: $referenceTypeTitle, referenceTypeID: $referenceTypeID, inActive: $inActive)';
  }

  @override
  bool operator ==(covariant ReferenceTypeModel other) {
    if (identical(this, other)) return true;

    return other.companyID == companyID &&
        other.userID == userID &&
        other.referenceTypeTitle == referenceTypeTitle &&
        other.referenceTypeID == referenceTypeID &&
        other.inActive == inActive;
  }

  @override
  int get hashCode {
    return companyID.hashCode ^
        userID.hashCode ^
        referenceTypeTitle.hashCode ^
        referenceTypeID.hashCode ^
        inActive.hashCode;
  }
}
