import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/screens/login_screen.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

// ignore: must_be_immutable
class LogOutUserComponent extends StatelessWidget {
  const LogOutUserComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      title: Text(
        "Confirmation",
        style: GoogleFonts.raleway(),
      ),
      content: Text(
        "Are you sure you want to logout?",
        style: GoogleFonts.raleway(),
      ),
      actions: [
        GestureDetector(
            onTap: () {
              // SecureStorage secureStorage = SecureStorage();
              // secureStorage.deleteSecureData(SecureStorageKeys.userId);
              // secureStorage.deleteSecureData(SecureStorageKeys.username);
              // secureStorage.deleteSecureData(SecureStorageKeys.email);

              // Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Constants.dangerColor,
                  borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "Yes",
                style: GoogleFonts.raleway(color: Colors.white),
              ),
            )),
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "No",
                style: GoogleFonts.raleway(),
              ),
            )),
      ],
    );
  }
}
