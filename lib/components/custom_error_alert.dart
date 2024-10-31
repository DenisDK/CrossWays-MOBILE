import 'package:flutter/material.dart';

class CustomAlert {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    Color titleColor = const Color.fromARGB(255, 135, 100, 71),
    Color contentColor = const Color.fromARGB(255, 135, 100, 71),
    double titleFontSize = 22.0,
    double contentFontSize = 18.0,
    Color buttonColor = const Color.fromARGB(255, 135, 100, 71),
    String buttonText = 'OK',
    Color dialogBackgroundColor = const Color.fromARGB(255, 231, 229, 225),
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
