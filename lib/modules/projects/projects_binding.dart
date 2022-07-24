import 'package:get/get.dart';

import 'projects_controller.dart';

class ProjectsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(
        () => ProjectsController(
              apiRepository: Get.find(),
              repository: Get.find(),
            ),
        fenix: true);
  }
}
