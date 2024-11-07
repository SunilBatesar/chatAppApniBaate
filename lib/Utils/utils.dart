import 'package:flutter/material.dart';

class AppUtils {
  // ------ Focus Change--------
  // --------
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
