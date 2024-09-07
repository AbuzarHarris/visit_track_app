import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonFunctions {
  static String getTimeAgo({required String datetime}) {
    final Duration difference =
        DateTime.now().difference(DateTime.parse(datetime));

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  static void editRecordConfirmDialog(
      {required BuildContext context, required GestureTapCallback ontap}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            icon: const Icon(
              Icons.edit_note_rounded,
              size: 40,
              color: Colors.green,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            content: Text(
              "Are you sure you want to update this record?",
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(fontSize: 15),
            ),
            actions: [
              GestureDetector(
                  onTap: ontap,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "No",
                      style: GoogleFonts.raleway(),
                    ),
                  )),
            ],
          );
        });
  }

  static void deleteRecordConfirmDialog(
      {required BuildContext context, required GestureTapCallback ontap}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            icon: const Icon(
              Icons.delete_forever_rounded,
              size: 40,
              color: Colors.red,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            content: Text(
              "Are you sure you want to delete this record?",
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(fontSize: 15),
            ),
            actions: [
              GestureDetector(
                  onTap: ontap,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "No",
                      style: GoogleFonts.raleway(),
                    ),
                  )),
            ],
          );
        });
  }
}
