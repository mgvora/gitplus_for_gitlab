import 'package:get/get.dart';

import 'add_members_controller.dart';

class AddMembersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMembersController>(
        () => AddMembersController(
              apiRepository: Get.find(),
              repository: Get.find(),
            ),
        fenix: true);
  }
}
