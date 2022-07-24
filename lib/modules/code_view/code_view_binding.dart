import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'code_view_controller.dart';

class CodeViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeViewController>(
        () => CodeViewController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
