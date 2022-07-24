import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class BaseProvider {
  late d.Dio dio;

  static var loading = false.obs;

  BaseProvider() {
    final data = Get.find<SecureStorage>();

    dio = d.Dio();

    dio.options = BaseOptions(
      connectTimeout: 8000,
      sendTimeout: 8000,
      receiveTimeout: 8000,
    );

    dio.interceptors.add(d.InterceptorsWrapper(
      onRequest: (req, handler) async {
        loading.value = true;

        if (data.getToken().isNotEmpty) {
          var token = data.getToken();
          req.headers['Authorization'] = 'Bearer $token';
        }
        req.baseUrl = data.getBaseurl();
        return handler.next(req);
      },
      onResponse: (res, handler) {
        EasyLoading.dismiss();
        loading.value = false;

        if (!okStatusCodes.contains(res.statusCode)) {
          CommonWidget.toast("An error occured");
        }
        return handler.next(res);
      },
      onError: (e, handler) {
        EasyLoading.dismiss();
        loading.value = false;
        return handler.next(e);
      },
    ));
  }

  var okStatusCodes = [200, 201, 202, 204];
}
