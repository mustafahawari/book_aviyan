import 'package:flutter/material.dart';

class ErrorDialog {
  static Future<void> authErrorHandle(
      String message, BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error Occured"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }
}
