import 'dart:convert';

import 'package:personal_phone_dictionary/models/api_response.dart';
import 'package:personal_phone_dictionary/models/delete_record_model.dart';
import 'package:personal_phone_dictionary/models/get_where_model.dart';
import 'package:personal_phone_dictionary/models/reference_type_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> insertUpdateReferenceTypeAsync(
    ReferenceTypeModel model) async {
  try {
    String url =
        "${APIConstants.baseUrl}/api/ReferenceType/ReferenceTypeInsertUpdate";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: model.toJson());

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

Future<ApiResponse<List<ReferenceTypeModel>, dynamic>>
    getReferenceTypeListAysnc(GetWhereModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/ReferenceType/GetReferenceTypes";

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
          data.map((item) => ReferenceTypeModel.fromJson(item)).toList();
      return ApiResponse(success: true, data: decodedData);
    } else {
      return ApiResponse(success: false, message: "${responseBody['Error']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}

Future<ApiResponse> deleteRefernceTypeAsync(DeleteRecordModel model) async {
  try {
    String url =
        "${APIConstants.baseUrl}/api/ReferenceType/DeleteReferenceType";

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
