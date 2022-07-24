import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'tree_view_controller.dart';

class TreeViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TreeViewController>(
        () => TreeViewController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
