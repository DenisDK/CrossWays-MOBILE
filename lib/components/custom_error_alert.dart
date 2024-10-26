import 'package:flutter/material.dart';

class CustomAlertDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    Color titleColor = Colors.blueAccent,
    Color contentColor = Colors.grey,
    double titleFontSize = 18.0,
    double contentFontSize = 16.0,
    Color buttonColor = const Color.fromARGB(255, 49, 133, 52),
    String buttonText = 'OK',
    Color dialogBackgroundColor = Colors.white,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: dialogBackgroundColor,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w900,
              fontSize: titleFontSize,
            ),
          ),
          content: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: contentColor,
              fontWeight: FontWeight.normal,
              fontSize: contentFontSize,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: buttonColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}
