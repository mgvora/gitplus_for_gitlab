import 'package:get/get.dart';

import 'starrers_controller.dart';

class StarrersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarrersController>(() => StarrersController(
          apiRepository: Get.find(),
          repository: Get.find(),
        ));
  }
}
