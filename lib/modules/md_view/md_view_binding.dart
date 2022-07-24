import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'md_view_controller.dart';

class MdViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MdViewController>(
        () => MdViewController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
