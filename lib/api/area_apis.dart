import 'dart:convert';
import 'dart:ffi';

import 'package:personal_phone_dictionary/models/area_list_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

Future<String> areaInsertUpdate(AreaListModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/Area/AreaInsertUpdate";
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: model.toJson());
    String msg = "";
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['message'] == "" && responseBody['success'] == true) {
      return msg;
    } else {
      throw Exception("${responseBody['message']}");
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<List<AreaListModel>> getAllAreas(Int64? masterID) async {
  try {
    SecureStorage secureStorage = SecureStorage();
    String userID = await secureStorage.readSecureData("userID");
    String companyID = await secureStorage.readSecureData("companyID");

    Map<String, dynamic> jsonBody = {
      'UserID': userID,
      'CompanyID': companyID,
      'MasterID': masterID ?? 0
    };

    String url = "${APIConstants.baseUrl}/api/Area/GetAreas";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonBody));

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['message'] == "" && responseBody['success'] == true) {
      List<dynamic> data = responseBody['data'];
      return data.map((item) => AreaListModel.fromMap(item)).toList();
    } else {
      throw Exception("${responseBody['message']}");
    }
  } catch (e) {
    throw Exception(e);
  }
}
