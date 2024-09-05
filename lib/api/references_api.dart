import 'dart:convert';

import 'package:personal_phone_dictionary/models/api_response.dart';
import 'package:personal_phone_dictionary/models/delete_record_model.dart';
import 'package:personal_phone_dictionary/models/get_where_model.dart';
import 'package:personal_phone_dictionary/models/reference_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> insertUpdateReferenceAsync(ReferenceModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/References/ReferenceInsertUpdate";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(model.toJson()));
    String msg = "";
    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['success'] == true) {
      return ApiResponse(success: true, message: msg);
    } else {
      return ApiResponse(success: false, message: "${responseBody['Error']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}

Future<ApiResponse<List<ReferenceModel>, dynamic>> getReferenceListAysnc(
    GetWhereModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/References/GetReferenceTypes";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      List<dynamic> data = responseBody['data'];
      var decodedData =
          data.map((item) => ReferenceModel.fromJson(item)).toList();
      return ApiResponse(success: true, data: decodedData);
    } else {
      return ApiResponse(success: false, message: "${responseBody['Error']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}

Future<ApiResponse> deleteRefernceAsync(DeleteRecordModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/References/DeleteReferences";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      return ApiResponse(
          success: true, message: "Reference Successfully Deleted!");
    } else {
      return ApiResponse(success: false, message: "${responseBody['Error']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}
