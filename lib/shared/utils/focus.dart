import 'package:flutter/cupertino.dart';

class AppFocus {
  static void nextFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
