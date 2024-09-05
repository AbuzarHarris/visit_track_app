import 'dart:convert';

import 'package:personal_phone_dictionary/models/area_list_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';
import 'package:http/http.dart' as http;

Future<String> areaInsertUpdate(AreaListModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/Area/AreaInsertUpdate";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(model.toJson()));
    String msg = "";
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['Error'] == "") {
      return msg;
    } else {
      throw Exception("${responseBody['Error']}");
    }
  } catch (e) {
    throw Exception(e);
  }
}
