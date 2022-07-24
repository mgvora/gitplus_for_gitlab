import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'edit_project_snippet_controller.dart';

class EditProjectSnippetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProjectSnippetController>(
        () => EditProjectSnippetController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
