import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'issues_controller.dart';

class IssuesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IssuesController>(
        () => IssuesController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
