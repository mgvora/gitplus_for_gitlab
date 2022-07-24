import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'issue_notes_controller.dart';

class IssueNotesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IssueNotesController>(
        () => IssueNotesController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
