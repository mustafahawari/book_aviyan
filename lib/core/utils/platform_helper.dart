import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformHelper {
  static isWeb() {
    return kIsWeb;
  }
  static bool isTab(context) {
    final size = MediaQuery
        .of(context)
        .size
        .width;
    if (size < 1300 && size >= 650) {
      return true;
    } else {
      return false;
    }
  }
}