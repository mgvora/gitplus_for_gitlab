import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'edit_issue_note_controller.dart';

class EditIssueNoteBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditIssueNoteController>(
        () => EditIssueNoteController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
