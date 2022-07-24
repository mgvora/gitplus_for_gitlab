import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'merge_request_controller.dart';

class MergeRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MergeRequestController>(
        () => MergeRequestController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
