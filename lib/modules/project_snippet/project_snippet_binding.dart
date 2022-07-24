import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'project_snippet_controller.dart';

class ProjectSnippetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectSnippetController>(
        () => ProjectSnippetController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
