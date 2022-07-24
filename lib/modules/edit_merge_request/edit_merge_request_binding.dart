import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'edit_merge_request_controller.dart';

class EditMergeRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditMergeRequestController>(
        () => EditMergeRequestController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
