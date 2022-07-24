import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'edit_milestone_controller.dart';

class EditMilestoneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMilestoneController>(
        () => EditMilestoneController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
