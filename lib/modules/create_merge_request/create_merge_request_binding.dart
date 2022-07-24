import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'create_merge_request_controller.dart';

class CreateMergeRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateMergeRequestController>(
        () => CreateMergeRequestController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
