import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'project_details_controller.dart';

class ProjectDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => ProjectDetailsController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
