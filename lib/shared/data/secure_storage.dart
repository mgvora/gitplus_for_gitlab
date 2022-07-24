import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:gitplus_for_gitlab/shared/shared.dart';

class SecureStorage {
  late SecureAppSettings _appData;
  late FlutterSecureStorage _storage;
  var _accessToken = "";
  var _baseUrl = "";

  final userChanged = 0.obs;

  Future<void> init() async {
    _appData = SecureAppSettings();
    _storage = const FlutterSecureStorage();

    // await clearAll();

    var raw =
        await _storage.read(key: SecureStorageConstants.appSettings) ?? '{}';
    _appData = SecureAppSettings.fromJson(json.decode(raw));
    _appData.accounts ??= [];

    if (_appData.accounts != null &&
        _appData.accounts!.isNotEmpty &&
        _appData.accounts!
            .any((element) => element.userId == _appData.defaultId)) {
      var defaultAccount = _appData.accounts!
          .singleWhere((element) => element.userId == _appData.defaultId);

      _baseUrl = defaultAccount.baseUrl!;
      _accessToken = defaultAccount.accessToken!;
    }

    // _appData.accounts![0].accessToken =
    //     '234ec004f8baa4cef7826dd7ec5302d811d93e3af71cb832f5394ae226d02553';
    // _accessToken = _appData.accounts![0].accessToken!;
  }

  Future<void> addUpdateAccount(AppAccount value) async {
    var update =
        _appData.accounts!.any((element) => element.userId == value.userId);

    if (update) {
      var i = _appData.accounts!
          .indexWhere((element) => element.userId == value.userId);
      _appData.accounts![i] = AppAccount.fromJson(value.toJson());
    } else {
      _appData.accounts!.add(value);
    }

    await _save();
  }

  setToken(String value) {
    _accessToken = value;
  }

  String getToken() {
    return _accessToken;
  }

  setBaseUrl(String value) {
    _baseUrl = value;
  }

  String getBaseurl() {
    return _baseUrl;
  }

  Future<void> setDefaultAccount(AppAccount value) async {
    _appData.defaultId = value.userId;

    _accessToken = value.accessToken!;
    _baseUrl = value.baseUrl!;

    userChanged.value++;

    await _save();
  }

  AppAccount getDefaultAccount() {
    return _appData.accounts!
        .singleWhere((element) => element.userId == _appData.defaultId);
  }

  Future<void> removeAccount(AppAccount account) async {
    _appData.accounts
        ?.removeWhere((element) => element.userId == account.userId);
    await _save();
  }

  List<AppAccount> getAccounts() => _appData.accounts!;

  Future<void> _save() async {
    await _storage.write(
        key: SecureStorageConstants.appSettings,
        value: _appData.toJsonString());
  }

  Future<void> clearAll() async {
    _appData = SecureAppSettings(accounts: [], defaultId: -1);
    await _storage.deleteAll();
  }
}
