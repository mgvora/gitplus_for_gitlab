import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'edit_project_label_controller.dart';

class EditProjectLabelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProjectLabelController>(
        () => EditProjectLabelController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
