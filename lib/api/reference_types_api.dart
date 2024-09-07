import 'dart:convert';
import 'package:personal_phone_dictionary/models/api_response.dart';
import 'package:personal_phone_dictionary/models/dropdown_models.dart';
import 'package:personal_phone_dictionary/models/reference_type_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:personal_phone_dictionary/utils/secure_strorage.dart';

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
      return ApiResponse(success: false, message: "${responseBody['message']}");
    }
  } catch (e) {
    return ApiResponse(success: false, message: "$e");
  }
}

// Future<ApiResponse<List<ReferenceTypeModel>, dynamic>>
//     getReferenceTypeListAysnc(GetWhereModel model) async {
//   try {
//     String url = "${APIConstants.baseUrl}/api/ReferenceType/GetReferenceTypes";

//     final response = await http.post(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//     );

//     Map<String, dynamic> responseBody = jsonDecode(response.body);
//     if (responseBody['success'] == true) {
//       List<dynamic> data = responseBody['data'];
//       var decodedData =
//           data.map((item) => ReferenceTypeModel.fromJson(item)).toList();
//       return ApiResponse(success: true, data: decodedData);
//     } else {
//       return ApiResponse(success: false, message: "${responseBody['Error']}");
//     }
//   } catch (e) {
//     return ApiResponse(success: false, message: "$e");
//   }
// }

// Future<ApiResponse> deleteRefernceTypeAsync(DeleteRecordModel model) async {
//   try {
//     String url =
//         "${APIConstants.baseUrl}/api/ReferenceType/DeleteReferenceType";

//     final response = await http.post(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//     );

//     Map<String, dynamic> responseBody = jsonDecode(response.body);
//     if (responseBody['success'] == true) {
//       return ApiResponse(
//           success: true, message: "Reference Successfully Deleted!");
//     } else {
//       return ApiResponse(success: false, message: "${responseBody['Error']}");
//     }
//   } catch (e) {
//     return ApiResponse(success: false, message: "$e");
//   }
// }

Future<List<ReferenceTypeModel>> getAllReferenceTypes(int? masterID) async {
  try {
    SecureStorage secureStorage = SecureStorage();
    String userID = await secureStorage.readSecureData("userID");
    String companyID = await secureStorage.readSecureData("companyID");

    Map<String, dynamic> jsonBody = {
      'UserID': userID,
      'CompanyID': companyID,
      'MasterID': masterID ?? 0
    };

    String url = "${APIConstants.baseUrl}/api/ReferenceType/GetReferenceTypes";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonBody));

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['message'] == "" && responseBody['success'] == true) {
      List<dynamic> data = responseBody['data'];
      return data.map((item) => ReferenceTypeModel.fromMap(item)).toList();
    } else {
      throw Exception("${responseBody['message']}");
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future<String> deleteReferenceTypes(int masterID) async {
  try {
    SecureStorage secureStorage = SecureStorage();
    String userID = await secureStorage.readSecureData("userID");
    String companyID = await secureStorage.readSecureData("companyID");

    Map<String, dynamic> jsonBody = {
      'UserID': userID,
      'CompanyID': companyID,
      'MasterID': masterID
    };

    String url =
        "${APIConstants.baseUrl}/api/ReferenceType/DeleteReferenceType";
    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonBody));
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

Future<List<ReferenceTypeDropdownModel>> getReferenceTypeDropdown() async {
  try {
    SecureStorage secureStorage = SecureStorage();
    String userID = await secureStorage.readSecureData("userID");
    String companyID = await secureStorage.readSecureData("companyID");

    Map<String, dynamic> jsonBody = {'UserID': userID, 'CompanyID': companyID};

    String url = "${APIConstants.baseUrl}/api/Dropdown/ReferenceTypeDropdown";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonBody));

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['message'] == "" && responseBody['success'] == true) {
      List<dynamic> data = responseBody['data'];
      return data
          .map((item) => ReferenceTypeDropdownModel.fromJson(item))
          .toList();
    } else {
      throw Exception("${responseBody['message']}");
    }
  } catch (e) {
    throw Exception(e);
  }
}
