import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:gitplus_for_gitlab/shared/utils/common_widget.dart';

typedef HttpFunction = Future<void> Function();

enum HttpState { loading, error, empty, ok, tokenExpired }

mixin HttpController {
  var state = HttpState.loading.obs;

  Future<int> runWithErrorHandling(HttpFunction function) async {
    try {
      state.value = HttpState.loading;
      await function();
      state.value = HttpState.ok;
      return 0;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        state.value = HttpState.tokenExpired;
        return handleTokenExiration(function);
      }
      if (e.response?.statusCode == 403) {
        CommonWidget.toast('Forbidden');
        state.value = HttpState.error;
        return 0;
      }

      state.value = HttpState.error;

      return e.response?.statusCode ?? 0;
    }
  }

  Future<int> runWithErrorHandlingWithoutState(HttpFunction function) async {
    // handleTokenExiration();

    try {
      await function();
      return 0;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        state.value = HttpState.tokenExpired;
        return handleTokenExiration(function);
      }

      return e.response?.statusCode ?? 0;
    }
  }

  handleHttpActionState(int code) {
    if (code == 0) {
      state.value = HttpState.ok;
      return;
    }

    if (code == 401) {
      handleTokenExiration(null);

      state.value = HttpState.tokenExpired;
    } else if (code == 403) {
      state.value = HttpState.error;
      CommonWidget.toast('Forbidden');
    } else {
      state.value = HttpState.error;
      CommonWidget.toast(CommonConstants.errorMessage);
    }
  }

  handleHttpActionWithoutState(int code) {
    if (code == 0) {
      return;
    }

    if (code == 401) {
      state.value = HttpState.tokenExpired;

      handleTokenExiration(null);

      return 0;
    }

    if (code == 403) {
      CommonWidget.toast('Forbidden');
    } else {
      CommonWidget.toast(CommonConstants.errorMessage);
    }
  }

  Future<int> handleTokenExiration(HttpFunction? function) async {
    var repository = Get.find<ApiRepository>();
    var sstorage = Get.find<SecureStorage>();

    var acc = sstorage.getDefaultAccount();

    if (acc.refreshToken == null || acc.refreshToken == "") {
      Get.toNamed(Routes.auth);
      CommonWidget.toast('Please re-authorize your token.');
      return 401;
    }

    try {
      var res = await repository.refreshToken(RefreshTokenRequest(
          grantType: 'refresh_token', refreshToken: acc.refreshToken!));

      acc.accessToken = res!.accessToken;
      acc.refreshToken = res.refreshToken;

      sstorage.addUpdateAccount(acc);

      sstorage.setToken(acc.accessToken!);

      if (function != null) {
        await function();
      }

      CommonWidget.toast('Your access token has been renewed.');

      return 0;
    } on DioError catch (e) {
      Get.toNamed(Routes.auth);
      CommonWidget.toast('Please re-authorize your token.');
    }

    return 401;
  }
}
