import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'issue_related_merge_requests_controller.dart';

class IssueRelatedMergeRequestsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IssueRelatedMergeRequestsController>(
        () => IssueRelatedMergeRequestsController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
