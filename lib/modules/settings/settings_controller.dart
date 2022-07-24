import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

class SettingsController extends GetxController {
  final spStorage = Get.find<SPStorage>();

  var theme = "".obs;
  var fontSize = 0.0.obs;
  var updateUI = 0.obs;

  Timer? _updateTimer;

  @override
  void onInit() async {
    super.onInit();
    changeTheme();
    fontSize.value = spStorage.getFontSize().toDouble();
  }

  @override
  void onClose() {
    _updateTimer?.cancel();
    super.onClose();
  }

  void changeThemeValue(int value) {
    switch (value) {
      case AppTheme.light:
        Get.changeThemeMode(ThemeMode.light);
        break;
      case AppTheme.dark:
        Get.changeThemeMode(ThemeMode.dark);
        break;
      case AppTheme.system:
        Get.changeThemeMode(ThemeMode.system);
        break;
    }
    spStorage.setTheme(value);
    changeTheme();

    if (_updateTimer != null && _updateTimer!.isActive) return;
    _updateTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      updateUI.value++;
      timer.cancel();
    });
  }

  void changeTheme() {
    if (spStorage.getTheme().value == AppTheme.dark) {
      theme.value = "On".tr;
    } else if (spStorage.getTheme().value == AppTheme.light) {
      theme.value = "Off".tr;
    } else {
      theme.value = "System".tr;
    }
  }

  void onShowLineNumbersChanged(bool value) {
    spStorage.setShowLineNumbers(value);
  }

  void onFontSizeChanged(double value) {
    fontSize.value = value.roundToDouble();
  }

  void onFontSizeChangedEnd(double value) {
    spStorage.setFontSize(value.toInt());
  }

  onResetDefault() async {
    await spStorage.resetSettings();
    changeThemeValue(spStorage.getTheme().value);
    fontSize.value = spStorage.getFontSize().value.toDouble();
  }
}
