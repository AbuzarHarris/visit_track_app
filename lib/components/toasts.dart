import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart'; // Ensure you have this package installed
import 'package:google_fonts/google_fonts.dart';

class ToastUtils {
  static void showOkToast(
      {required BuildContext context, // Context is required to show the toast
      required String message,
      Icon? icon}) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      //title: const Text('Hello, World!'),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: TextSpan(
              text: message,
              style: GoogleFonts.raleway(color: Colors.white, fontSize: 12))),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          //turns: animation,
          opacity: animation,
          //turns: animation,
          child: child,
        );
      },
      icon: icon,
      showIcon: true, // show or hide the icon
      primaryColor: Colors.green[400],
      backgroundColor: Colors.green[400],
      //foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 0),
      // boxShadow: const [
      //   BoxShadow(
      //     color: Color(0x07000000),
      //     blurRadius: 5,
      //     offset: Offset(0, 5),
      //     spreadRadius: 0,
      //   )
      // ],
      showProgressBar: false,
      progressBarTheme: ProgressIndicatorThemeData(
          color: Colors.green[200], linearMinHeight: 0.5),
      closeButtonShowType: CloseButtonShowType.always,
      foregroundColor: Colors.white,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,

      applyBlurEffect: true,
    );
  }

  static void showErrorToast(
      {required BuildContext context, // Context is required to show the toast
      required String message,
      Icon? icon}) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 5),
      //title: const Text('Hello, World!'),
      // you can also use RichText widget for title and description parameters
      description: RichText(
          text: TextSpan(
              text: message,
              style: GoogleFonts.raleway(color: Colors.white, fontSize: 12))),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          //turns: animation,
          opacity: animation,
          //turns: animation,
          child: child,
        );
      },
      icon: icon,
      showIcon: true, // show or hide the icon
      primaryColor: Colors.red[400],
      backgroundColor: Colors.red[400],
      //foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(width: 0),
      // boxShadow: const [
      //   BoxShadow(
      //     color: Color(0x07000000),
      //     blurRadius: 5,
      //     offset: Offset(0, 5),
      //     spreadRadius: 0,
      //   )
      // ],
      showProgressBar: false,
      progressBarTheme: ProgressIndicatorThemeData(
          color: Colors.red[200], linearMinHeight: 0.5),
      closeButtonShowType: CloseButtonShowType.always,
      foregroundColor: Colors.white,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,

      applyBlurEffect: true,
    );
  }
}
