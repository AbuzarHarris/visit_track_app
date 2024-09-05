import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:personal_phone_dictionary/models/api_response.dart';
import 'package:personal_phone_dictionary/models/login_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

String serialnumber = "";

Future<ApiResponse<LoginModel, LoginErrorModel>> loginusercheck(
    String email, String password) async {
  try {
    String url =
        "${APIConstants.baseUrl}/api/Login/LoginUser?EmailAddress=$email&Password=$password";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['approved'] == false) {
      List<dynamic> data = responseBody['LoginCheck'];
      return ApiResponse<LoginModel, LoginErrorModel>(
          success: false,
          errCode: "UNAPPROVED",
          message:
              "Your account is not verified. Please verify your account first to login.",
          addtionalData: LoginErrorModel(userId: responseBody['userId']),
          data: data.map((item) => LoginModel.fromJson(item)).toList()[0]);
    } else if (responseBody['approved'] == true &&
        responseBody['success'] == true) {
      List<dynamic> data = responseBody['LoginCheck'];
      var userData = data.map((item) => LoginModel.fromJson(item)).toList()[0];

      return ApiResponse<LoginModel, LoginErrorModel>(
        success: true,
        message: "",
        data: userData,
      );
    } else {
      throw Exception("Incorrect email or password.");
    }
  } catch (e) {
    throw Exception(e);
  }
}

// Future<void> _getSerialNumber() async {
//   const platform = MethodChannel('com.example.serial_number');
//   try {
//     final String result = await platform.invokeMethod('getSerialNumber');
//     serialnumber = result;
//   } on PlatformException catch (e) {
//     serialnumber = "Failed to get serial number: '${e.message}'.";
//   }
// }
