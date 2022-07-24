import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'project_activity_controller.dart';

class ProjectActivityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectActivityController>(
        () => ProjectActivityController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
