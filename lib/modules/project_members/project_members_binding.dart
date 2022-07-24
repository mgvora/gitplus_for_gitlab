import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'project_members_controller.dart';

class ProjectMembersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectMembersController>(
        () => ProjectMembersController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
