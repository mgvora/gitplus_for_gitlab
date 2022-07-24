import 'package:get/get.dart';

import 'project_snippets_controller.dart';

class ProjectSnippetsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectSnippetsController>(
        () => ProjectSnippetsController(
              apiRepository: Get.find(),
              repository: Get.find(),
            ),
        fenix: true);
  }
}
