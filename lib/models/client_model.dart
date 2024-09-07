// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClientModel {
  int companyID;
  int userID;
  int? clientID;
  String? clientName;
  String? phoneNumber;
  String? phoneNumber2;
  String? whatsappNumber;
  int? referenceID;
  String? referenceTitle;
  int? areaID;
  String? areaTitle;
  List<String>? tags;
  double? longitude;
  double? latitude;
  String? entryDate;
  ClientModel({
    required this.companyID,
    required this.userID,
    this.clientID,
    this.clientName,
    this.phoneNumber,
    this.phoneNumber2,
    this.whatsappNumber,
    this.referenceID,
    this.referenceTitle,
    this.areaID,
    this.areaTitle,
    this.tags,
    this.longitude,
    this.latitude,
    this.entryDate,
  });

  ClientModel copyWith({
    int? companyID,
    int? userID,
    int? clientID,
    String? clientName,
    String? phoneNumber,
    String? phoneNumber2,
    String? whatsappNumber,
    int? referenceID,
    String? referenceTitle,
    int? areaID,
    String? areaTitle,
    List<String>? tags,
    double? longitude,
    double? latitude,
    String? entryDate,
  }) {
    return ClientModel(
      companyID: companyID ?? this.companyID,
      userID: userID ?? this.userID,
      clientID: clientID ?? this.clientID,
      clientName: clientName ?? this.clientName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      referenceID: referenceID ?? this.referenceID,
      referenceTitle: referenceTitle ?? this.referenceTitle,
      areaID: areaID ?? this.areaID,
      areaTitle: areaTitle ?? this.areaTitle,
      tags: tags ?? this.tags,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      entryDate: entryDate ?? this.entryDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyID': companyID,
      'userID': userID,
      'clientID': clientID,
      'clientName': clientName,
      'phoneNumber': phoneNumber,
      'phoneNumber2': phoneNumber2,
      'whatsappNumber': whatsappNumber,
      'referenceID': referenceID,
      'referenceTitle': referenceTitle,
      'areaID': areaID,
      'areaTitle': areaTitle,
      'tags': tags,
      'longitude': longitude,
      'latitude': latitude,
      'entryDate': entryDate,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      companyID: map['companyID'] as int,
      userID: map['userID'] as int,
      clientID: map['clientID'] != null ? map['clientID'] as int : null,
      clientName:
          map['clientName'] != null ? map['clientName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      phoneNumber2:
          map['phoneNumber2'] != null ? map['phoneNumber2'] as String : null,
      whatsappNumber: map['whatsappNumber'] != null
          ? map['whatsappNumber'] as String
          : null,
      referenceID:
          map['referenceID'] != null ? map['referenceID'] as int : null,
      referenceTitle: map['referenceTitle'] != null
          ? map['referenceTitle'] as String
          : null,
      areaID: map['areaID'] != null ? map['areaID'] as int : null,
      areaTitle: map['areaTitle'] != null ? map['areaTitle'] as String : null,
      tags: map['tags'] != null
          ? List<String>.from((map['tags'] as List<String>))
          : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      entryDate: map['entryDate'] != null ? map['entryDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientModel.fromJson(String source) =>
      ClientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClientModel(companyID: $companyID, userID: $userID, clientID: $clientID, clientName: $clientName, phoneNumber: $phoneNumber, phoneNumber2: $phoneNumber2, whatsappNumber: $whatsappNumber, referenceID: $referenceID, referenceTitle: $referenceTitle, areaID: $areaID, areaTitle: $areaTitle, tags: $tags, longitude: $longitude, latitude: $latitude, entryDate: $entryDate)';
  }

  @override
  bool operator ==(covariant ClientModel other) {
    if (identical(this, other)) return true;

    return other.companyID == companyID &&
        other.userID == userID &&
        other.clientID == clientID &&
        other.clientName == clientName &&
        other.phoneNumber == phoneNumber &&
        other.phoneNumber2 == phoneNumber2 &&
        other.whatsappNumber == whatsappNumber &&
        other.referenceID == referenceID &&
        other.referenceTitle == referenceTitle &&
        other.areaID == areaID &&
        other.areaTitle == areaTitle &&
        listEquals(other.tags, tags) &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.entryDate == entryDate;
  }

  @override
  int get hashCode {
    return companyID.hashCode ^
        userID.hashCode ^
        clientID.hashCode ^
        clientName.hashCode ^
        phoneNumber.hashCode ^
        phoneNumber2.hashCode ^
        whatsappNumber.hashCode ^
        referenceID.hashCode ^
        referenceTitle.hashCode ^
        areaID.hashCode ^
        areaTitle.hashCode ^
        tags.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        entryDate.hashCode;
  }
}

class TagsDropdownModel {
  int companyID;
  int userID;
  TagsDropdownModel({
    required this.companyID,
    required this.userID,
  });

  TagsDropdownModel copyWith({
    int? companyID,
    int? userID,
  }) {
    return TagsDropdownModel(
      companyID: companyID ?? this.companyID,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyID': companyID,
      'userID': userID,
    };
  }

  factory TagsDropdownModel.fromMap(Map<String, dynamic> map) {
    return TagsDropdownModel(
      companyID: map['CompanyID'] as int,
      userID: map['UserID'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TagsDropdownModel.fromJson(String source) =>
      TagsDropdownModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TagsDropdownModel(companyID: $companyID, userID: $userID)';

  @override
  bool operator ==(covariant TagsDropdownModel other) {
    if (identical(this, other)) return true;

    return other.companyID == companyID && other.userID == userID;
  }

  @override
  int get hashCode => companyID.hashCode ^ userID.hashCode;
}
