import 'dart:convert';
import 'dart:io';

import 'package:personal_phone_dictionary/models/api_response.dart';
import 'package:personal_phone_dictionary/models/client_model.dart';
import 'package:personal_phone_dictionary/models/delete_record_model.dart';
import 'package:personal_phone_dictionary/models/get_where_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> insertUpdateClientAsync(
    ClientModel model, File? file) async {
  try {
    String url = "${APIConstants.baseUrl}/api/Client/ClientInsertUpdate";
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('File', file.path));
    }
    request.fields['ClientName'] = model.clientName ?? "";
    request.fields['AreaTitle'] = model.areaTitle ?? "";
    request.fields['EntryDate'] = model.entryDate ?? "";
    request.fields['PhoneNumber'] = model.phoneNumber ?? "";
    request.fields['PhoneNumber2'] = model.phoneNumber2 ?? "";
    request.fields['ReferenceTitle'] = model.referenceTitle ?? "";
    request.fields['WhatsappNumber'] = model.whatsappNumber ?? "";
    request.fields['AreaID'] = model.areaID.toString();
    request.fields['ClientID'] = model.clientID.toString();
    request.fields['CompanyID'] = model.companyID.toString();
    request.fields['Latitude'] = model.latitude.toString();
    request.fields['Longitude'] = model.longitude.toString();
    request.fields['ReferenceID'] = model.referenceID.toString();
    request.fields['UserID'] = model.userID.toString();
    request.fields['Tags'] = model.tags.toString();

    var response = await request.send();

    final respStr = await response.stream.bytesToString();
    final responseBody = jsonDecode(respStr);

    if (responseBody['success'] == true) {
      return ApiResponse(success: true);
    } else {
      return ApiResponse(success: false, message: "${responseBody['message']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}

Future<ApiResponse<List<ClientModel>, dynamic>> getReferenceTypeListAysnc(
    GetWhereModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/ReferenceType/GetReferenceTypes";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: model.toJson());

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      List<dynamic> data = responseBody['data'];
      var decodedData = data.map((item) => ClientModel.fromJson(item)).toList();
      return ApiResponse(success: true, data: decodedData);
    } else {
      return ApiResponse(success: false, message: "${responseBody['Error']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}

Future<ApiResponse> deleteClientAsync(DeleteRecordModel model) async {
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
          success: true, message: "Client Successfully Deleted!");
    } else {
      return ApiResponse(success: false, message: "${responseBody['Error']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}

Future<ApiResponse<List<String>, dynamic>> getTagsListAsync(
    TagsDropdownModel model) async {
  try {
    String url = "${APIConstants.baseUrl}/api/Dropdown/TagsDropdown";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: model.toJson());

    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      List<dynamic> data = responseBody['data'];
      var decodedData = data.map((item) => item['Title'].toString()).toList();
      return ApiResponse(success: true, data: decodedData);
    } else {
      return ApiResponse(success: false, message: "${responseBody['Error']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}
