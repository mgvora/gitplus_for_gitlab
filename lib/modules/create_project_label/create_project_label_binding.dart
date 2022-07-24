import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'create_project_label_controller.dart';

class CreateProjectLabelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateProjectLabelController>(
        () => CreateProjectLabelController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
