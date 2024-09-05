import 'dart:convert';

import 'package:personal_phone_dictionary/models/area_list_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

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
