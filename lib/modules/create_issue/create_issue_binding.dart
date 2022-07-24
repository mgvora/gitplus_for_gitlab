import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'create_issue_controller.dart';

class CreateIssueBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateIssueController>(
        () => CreateIssueController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
