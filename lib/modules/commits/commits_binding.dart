import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'commits_controller.dart';

class CommitsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommitsController>(
        () => CommitsController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
