import 'dart:convert';

class ClientMasterModel {
  int companyID;
  int userID;
  int clientID;
  String clientName;
  String phoneNumber;
  String phoneNumber2;
  String whatsappNumber;
  int referenceID;
  String referenceTitle;
  int areaID;
  String areaTitle;

  ClientMasterModel({
    required this.companyID,
    required this.userID,
    required this.clientID,
    required this.clientName,
    required this.phoneNumber,
    required this.phoneNumber2,
    required this.whatsappNumber,
    required this.referenceID,
    required this.referenceTitle,
    required this.areaID,
    required this.areaTitle,
  });

  ClientMasterModel copyWith(
      {int? companyID,
      int? userID,
      int? clientID,
      String? clientName,
      String? phoneNumber,
      String? phoneNumber2,
      String? whatsappNumber,
      int? referenceID,
      String? referenceTitle,
      int? areaID,
      String? areaTitle}) {
    return ClientMasterModel(
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'CompanyID': companyID,
      'UserID': userID,
      'ClientID': clientID,
      'ClientName': clientName,
      'PhoneNumber': phoneNumber,
      'PhoneNumber2': phoneNumber2,
      'WhatsappNumber': whatsappNumber,
      'ReferenceID': referenceID,
      'ReferenceTitle': referenceTitle,
      'AreaID': areaID,
      'AreaTitle': areaTitle,
    };
  }

  factory ClientMasterModel.fromMap(Map<String, dynamic> map) {
    return ClientMasterModel(
      companyID: map['CompanyID'] as int,
      userID: map['UserID'] as int,
      clientID: map['ClientID'] as int,
      clientName: map['ClientName'] as String,
      phoneNumber: map['PhoneNumber'] as String,
      phoneNumber2: map['PhoneNumber2'] as String,
      whatsappNumber: map['WhatsappNumber'] as String,
      referenceID: map['ReferenceID'] as int,
      referenceTitle: map['ReferenceTitle'] as String,
      areaID: map['AreaID'] as int,
      areaTitle: map['AreaTitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientMasterModel.fromJson(String source) =>
      ClientMasterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class TagsModel {
  String tag;
  TagsModel({
    required this.tag,
  });
  factory TagsModel.fromJson(Map<String, dynamic> json) {
    return TagsModel(
      tag: json['Tag'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Tag': tag,
    };
  }
}

class ClientModel {
  ClientMasterModel master;
  List<TagsModel> tagsDetail;

  ClientModel({required this.master, required this.tagsDetail});
}
