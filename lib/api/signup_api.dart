import 'dart:convert';

import 'package:personal_phone_dictionary/models/api_response.dart';
import 'package:personal_phone_dictionary/models/login_model.dart';
import 'package:personal_phone_dictionary/models/signup_model.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';
import 'package:http/http.dart' as http;

Future<ApiResponse> resendOTP(String userID) async {
  try {
    String url = "${APIConstants.baseUrl}/api/SignUp/ResendOTP?UserID=$userID";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['success'] == true) {
      return ApiResponse<LoginModel, LoginErrorModel>(
        success: true,
        message:
            "The OTP has been resent to your email. If you don't see it in your inbox, please check your spam folder.",
      );
    } else {
      return ApiResponse<LoginModel, LoginErrorModel>(
        success: false,
        message: "Incorrect email or password.",
      );
    }
  } catch (e) {
    return ApiResponse<LoginModel, LoginErrorModel>(
      success: false,
      message: e.toString(),
    );
  }
}

Future<ApiResponse> newUserSignUp(SignupModel signupModel) async {
  try {
    String url = "${APIConstants.baseUrl}/api/SignUp/NewUserSignUp";

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: signupModel.toJson());

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['success'] == true) {
      return ApiResponse(
          success: true,
          message: "Account successfully created!",
          data: {"userID": responseBody["UserID"]});
    } else {
      return ApiResponse(
        success: false,
        message: responseBody["message"],
      );
    }
  } catch (e) {
    return ApiResponse(
      success: false,
      message: e.toString(),
    );
  }
}

Future verifyOTP(String userID, String oTP) async {
  try {
    String url =
        "${APIConstants.baseUrl}/api/SignUp/ValidateOTP?UserID=$userID&OTP=$oTP";

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (responseBody['success'] == false) {
      return responseBody['message'].toString();
    } else {
      return "";
    }
  } catch (e) {
    return e.toString();
  }
}
