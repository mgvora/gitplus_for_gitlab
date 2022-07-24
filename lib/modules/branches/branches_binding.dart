import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'branches_controller.dart';

class BranchesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchesController>(
        () => BranchesController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
