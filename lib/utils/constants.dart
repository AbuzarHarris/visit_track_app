import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static const Color bgColor = Color.fromRGBO(250, 250, 250, 1);
  static const Color textColor = Color.fromRGBO(0, 0, 0, 1);
  static const Color textinputColor = Color.fromRGBO(165, 165, 165, 0.071);
  static const Color primaryColor = Color.fromARGB(255, 13, 71, 161);

  static const Color secondaryColor = Color.fromRGBO(209, 13, 73, 1);
  static const Color dangerColor = Color(0xFFFF0000);
  static const Color accentColor = Color(0xFFFFC107);
}

class APIConstants {
  static const String baseUrl = 'http://edusoft.freeddns.org:122';
}

class SecureStorageKeys {
  static const String userId = "userid";
  static const String username = "username";
  static const String email = "email";
}
