import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/constants/constants.dart';

import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPStorage {
  late SharedPreferences _storage;

  /// settings
  late final _theme = 0.obs;
  late final _showLineNumbers = false.obs;
  late final _fontSize = 0.obs;

  /// auth
  late int _authDefaultTab;

  /// home
  late int _homeDefaultTab;
  late String _mergeRequestFilterScope;
  late String _mergeRequestFilterState;
  late String _issuesFilterScope;
  late String _issuesFilterState;

  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();

    // await _storage.clear();

    /// settings

    _theme.value = _storage.getInt(SPStorageConstants.theme) ?? AppTheme.system;
    _showLineNumbers.value =
        _storage.getBool(SPStorageConstants.showLineNumbers) ?? true;
    _fontSize.value = _storage.getInt(SPStorageConstants.fontSize) ?? 14;

    /// auth

    _authDefaultTab = _storage.getInt(SPStorageConstants.authDefaultTab) ?? 1;

    /// home

    _homeDefaultTab = _storage.getInt(SPStorageConstants.homeDefaultTab) ?? 0;
    _mergeRequestFilterScope =
        _storage.getString(SPStorageConstants.mergeRequestFilterScope) ??
            MergeRequestScope.all;
    _mergeRequestFilterState =
        _storage.getString(SPStorageConstants.mergeRequestFilterState) ??
            ''; // all
    _issuesFilterScope =
        _storage.getString(SPStorageConstants.issuesFilterScope) ??
            IssuesScope.all;
    _issuesFilterState =
        _storage.getString(SPStorageConstants.issuesFilterState) ?? ''; // all
  }

  /// settings

  setTheme(int value) {
    _theme.value = value;
    _storage.setInt(SPStorageConstants.theme, value);
  }

  RxInt getTheme() => _theme;

  setShowLineNumbers(bool value) {
    _showLineNumbers.value = value;
    _storage.setBool(SPStorageConstants.showLineNumbers, value);
  }

  RxBool getShowLineNumbers() => _showLineNumbers;

  setFontSize(int value) {
    _fontSize.value = value;
    _storage.setInt(SPStorageConstants.fontSize, value);
  }

  RxInt getFontSize() => _fontSize;

  /// auth

  setAuthDefaultTab(int value) {
    _authDefaultTab = value;
    _storage.setInt(SPStorageConstants.authDefaultTab, value);
  }

  int getAuthDefaultTab() => _authDefaultTab;

  /// home

  setHomeDefaultTab(int value) {
    _homeDefaultTab = value;
    _storage.setInt(SPStorageConstants.homeDefaultTab, value);
  }

  int getHomeDefaultTab() => _homeDefaultTab;

  setMergeRequestFilterScope(String value) {
    _mergeRequestFilterScope = value;
    _storage.setString(SPStorageConstants.mergeRequestFilterScope, value);
  }

  String getMergeRequestFilterScope() => _mergeRequestFilterScope;

  setMergeRequestFilterState(String value) {
    _mergeRequestFilterState = value;
    _storage.setString(SPStorageConstants.mergeRequestFilterState, value);
  }

  String getMergeRequestFilterState() => _mergeRequestFilterState;

  setIssuesFilterScope(String value) {
    _issuesFilterScope = value;
    _storage.setString(SPStorageConstants.issuesFilterScope, value);
  }

  String getIssuesFilterScope() => _issuesFilterScope;

  setIssuesFilterState(String value) {
    _issuesFilterState = value;
    _storage.setString(SPStorageConstants.issuesFilterState, value);
  }

  String getIssuesFilterState() => _issuesFilterState;

  Future<void> resetSettings() async {
    await setTheme(AppTheme.system);
    await setShowLineNumbers(true);
    await setFontSize(14);
  }
}

class AppTheme {
  static const light = 1;
  static const dark = 2;
  static const system = 3;
}

class AppCodeTheme {
  static const light = "vs"; //"github";
  static const dark = "vs2015"; // "dark";
  static const system = "system";
}
