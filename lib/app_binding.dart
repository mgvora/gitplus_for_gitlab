import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put(ApiProvider(), permanent: true);
    Get.put(ApiRepository(apiProvider: Get.find<ApiProvider>()),
        permanent: true);

    Get.put(Repository(), permanent: true);
  }
}
