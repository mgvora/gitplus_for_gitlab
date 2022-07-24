import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'commit_controller.dart';

class CommitBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommitController>(
        () => CommitController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
