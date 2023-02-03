import 'package:flutter/material.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showLoaderDialog(BuildContext context,
      {bool dismissible = true }) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text(
              'loading...',
              // AppLocalizations.of(context).translate("loading"),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}