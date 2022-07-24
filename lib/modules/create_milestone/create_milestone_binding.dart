import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'create_milestone_controller.dart';

class CreateMilestoneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateMilestoneController>(
        () => CreateMilestoneController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
