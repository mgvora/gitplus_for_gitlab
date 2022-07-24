import 'package:get/get.dart';

import 'about_controller.dart';

class AboutBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutController>(() => AboutController(), fenix: true);
  }
}
