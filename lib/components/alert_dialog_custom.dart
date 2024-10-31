import 'package:flutter/material.dart';

class CustomDialogAlert {
  static Future<bool?> showConfirmationDialog(
    BuildContext context,
    String title,
    String content,
  ) async {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 231, 229, 225),
          title: Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 135, 100, 71),
              fontSize: 28,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
              color: Color.fromARGB(255, 135, 100, 71),
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Ні',
                style: TextStyle(
                  color: Color.fromARGB(255, 135, 100, 71),
                   fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Так',
                style: TextStyle(
                  color: Color.fromARGB(255, 135, 100, 71),
                   fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}