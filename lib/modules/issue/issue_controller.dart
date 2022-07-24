import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/issue/issue_screen.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class IssueController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  IssueController({
    required this.apiRepository,
    required this.repository,
  });

  late PagingResponse<ProjectLabel> _labelsRes;

  var issues = <Issue>[].obs;

  late StreamSubscription _issueUpdateSubscription;

  var _dontLoadIssue = false;

  @override
  void onReady() async {
    super.onReady();
    listIssueLabels(1);

    if (repository.loadProjectRequired.value) {
      getProject();
    }

    _issueUpdateSubscription = repository.issuesUpdate.listen((p0) async {
      if (_dontLoadIssue) return;
      await getIssue();
      await listIssueLabels(1);
    });

    await getIssue();
    await listIssueLabels(1);
  }

  @override
  void onClose() {
    _issueUpdateSubscription.cancel();
    super.onClose();
  }

  Future<void> getProject() async {
    await runWithErrorHandlingWithoutState(() async {
      repository.project.value = await apiRepository.getProject(
              repository.projectId, ProjectRequest()) ??
          Project();
    });
  }

  Future<void> getIssue() async {
    await runWithErrorHandlingWithoutState(() async {
      repository.issue.value = await apiRepository.getProjectIssue(
              repository.project.value.id ?? repository.projectId,
              repository.issue.value.iid ?? repository.issueIid) ??
          Issue();
    });
  }

  Future<void> listIssueLabels(int page) async {
    await runWithErrorHandlingWithoutState(() async {
      _labelsRes = await apiRepository.listProjectLabels(
              repository.project.value.id ?? repository.projectId,
              ProjectLabelsRequest(page: page, perPage: 100)) ??
          PagingResponse<ProjectLabel>();

      var labels = initPagingList(_labelsRes);

      repository.issueLabels.clear();

      for (var item in labels) {
        if (repository.issue.value.labels != null &&
            repository.issue.value.labels!.contains(item.name)) {
          repository.issueLabels.add(item);
        }
      }
    });
  }

  onPopupSelected(IssueScreenPopupActions value, context) async {
    switch (value) {
      case IssueScreenPopupActions.edit:
        Get.toNamed(Routes.editIssue);
        break;
      case IssueScreenPopupActions.reopen:
        EasyLoading.show();
        await runWithErrorHandlingWithoutState(() async {
          await apiRepository.updateProjectIssue(
              repository.project.value.id ?? repository.projectId,
              repository.issue.value.iid ?? repository.issueIid,
              UpdateIssueRequest(stateEvent: IssueStateEvent.reopen));
          repository.issuesUpdate.value++;
        }).then((value) => handleHttpActionState(value));
        EasyLoading.dismiss();
        break;
      case IssueScreenPopupActions.close:
        EasyLoading.show();
        await runWithErrorHandlingWithoutState(() async {
          await apiRepository.updateProjectIssue(
              repository.project.value.id ?? repository.projectId,
              repository.issue.value.iid ?? repository.issueIid,
              UpdateIssueRequest(stateEvent: IssueStateEvent.close));
          repository.issuesUpdate.value++;
        }).then((value) => handleHttpActionState(value));
        EasyLoading.dismiss();
        break;
      case IssueScreenPopupActions.delete:
        showDialog(
          context: context,
          builder: (context) => QuestionMessagePresetsDialog(
            title: 'Delete issue'.tr,
            text: 'Are you sure?'.tr,
            action: () async {
              EasyLoading.show();
              _dontLoadIssue = true;
              await runWithErrorHandlingWithoutState(() async {
                await apiRepository.deleteProjectIssue(
                    repository.project.value.id ?? repository.projectId,
                    repository.issue.value.iid ?? repository.issueIid);
                repository.issuesUpdate.value++;
                Get.back();
              }).then((value) => handleHttpActionState(value));
              EasyLoading.dismiss();
            },
          ),
        );
        break;
      case IssueScreenPopupActions.share:
        Share.share(repository.issue.value.webUrl!);
        break;
      case IssueScreenPopupActions.openWeb:
        launch(repository.issue.value.webUrl!);
        break;
    }
  }

  onRefresh() async {
    await getIssue();
    await listIssueLabels(1);
  }
}
