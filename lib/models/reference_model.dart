// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReferenceModel {
  int companyID;
  int userID;
  int referenceID;
  String referenceTitle;
  int referenceTypeID;
  bool inActive;
  ReferenceModel({
    required this.companyID,
    required this.userID,
    required this.referenceID,
    required this.referenceTitle,
    required this.referenceTypeID,
    required this.inActive,
  });

  ReferenceModel copyWith({
    int? companyID,
    int? userID,
    int? referenceID,
    String? referenceTitle,
    int? referenceTypeID,
    bool? inActive,
  }) {
    return ReferenceModel(
      companyID: companyID ?? this.companyID,
      userID: userID ?? this.userID,
      referenceID: referenceID ?? this.referenceID,
      referenceTitle: referenceTitle ?? this.referenceTitle,
      referenceTypeID: referenceTypeID ?? this.referenceTypeID,
      inActive: inActive ?? this.inActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyID': companyID,
      'userID': userID,
      'referenceID': referenceID,
      'referenceTitle': referenceTitle,
      'referenceTypeID': referenceTypeID,
      'inActive': inActive,
    };
  }

  factory ReferenceModel.fromMap(Map<String, dynamic> map) {
    return ReferenceModel(
      companyID: map['companyID'] as int,
      userID: map['userID'] as int,
      referenceID: map['referenceID'] as int,
      referenceTitle: map['referenceTitle'] as String,
      referenceTypeID: map['referenceTypeID'] as int,
      inActive: map['inActive'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReferenceModel.fromJson(String source) =>
      ReferenceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReferenceModel(companyID: $companyID, userID: $userID, referenceID: $referenceID, referenceTitle: $referenceTitle, referenceTypeID: $referenceTypeID, inActive: $inActive)';
  }

  @override
  bool operator ==(covariant ReferenceModel other) {
    if (identical(this, other)) return true;

    return other.companyID == companyID &&
        other.userID == userID &&
        other.referenceID == referenceID &&
        other.referenceTitle == referenceTitle &&
        other.referenceTypeID == referenceTypeID &&
        other.inActive == inActive;
  }

  @override
  int get hashCode {
    return companyID.hashCode ^
        userID.hashCode ^
        referenceID.hashCode ^
        referenceTitle.hashCode ^
        referenceTypeID.hashCode ^
        inActive.hashCode;
  }
}
