import 'package:flutter/material.dart';

class ThemeUtils {
  static Color computeIluminance(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
}
