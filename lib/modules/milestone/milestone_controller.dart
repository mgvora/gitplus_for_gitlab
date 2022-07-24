import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/milestone/milestone_screen.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class MilestoneController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  MilestoneController({
    required this.apiRepository,
    required this.repository,
  });

  var issues = <Issue>[].obs;
  var mr = <MergeRequest>[].obs;
  var completePerc = 0.obs;
  var completePercProgress = 0.0.obs;

  late StreamSubscription _milestoneUpdateSubscription;

  var _dontReload = false;

  @override
  void onReady() async {
    _milestoneUpdateSubscription = repository.milestonesUpdate.listen((p0) {
      if (_dontReload) return;
      getMilestone();
    });

    onRefresh();

    super.onReady();
  }

  @override
  void onClose() {
    _milestoneUpdateSubscription.cancel();
    super.onClose();
  }

  Future<void> getMilestone() async {
    await runWithErrorHandlingWithoutState(() async {
      repository.milestone.value = await apiRepository.getProjectMilestone(
              repository.project.value.id ?? repository.projectId,
              repository.milestone.value.id ?? repository.milestoneId) ??
          ProjectMilestone();
    });
  }

  Future<void> getIssues() async {
    await runWithErrorHandlingWithoutState(() async {
      var res = await apiRepository.getMilestoneIssues(
              repository.project.value.id ?? repository.projectId,
              repository.milestone.value.id ?? repository.milestoneId) ??
          PagingResponse<Issue>();
      issues.value = initPagingList(res);
    });
  }

  Future<void> getMR() async {
    await runWithErrorHandlingWithoutState(() async {
      var res = await apiRepository.getMilestoneMR(
              repository.project.value.id ?? repository.projectId,
              repository.milestone.value.id ?? repository.milestoneId) ??
          PagingResponse<MergeRequest>();
      mr.value = initPagingList(res);
    });
  }

  onPopupSelected(MilestoneScreenPopupActions value, context) async {
    switch (value) {
      case MilestoneScreenPopupActions.edit:
        Get.toNamed(Routes.editMilestone);
        break;
      case MilestoneScreenPopupActions.close:
        EasyLoading.show();
        await runWithErrorHandlingWithoutState(() async {
          await apiRepository.updateProjectMilestone(
              repository.project.value.id ?? repository.projectId,
              repository.milestone.value.id ?? repository.milestoneId,
              AddUpdateMilestoneRequest(stateEvent: MilestoneStateEvent.close));
          repository.milestonesUpdate.value++;
        }).then((value) => handleHttpActionState(value));
        EasyLoading.dismiss();
        break;
      case MilestoneScreenPopupActions.reopen:
        EasyLoading.show();
        await runWithErrorHandlingWithoutState(() async {
          await apiRepository.updateProjectMilestone(
              repository.project.value.id ?? repository.projectId,
              repository.milestone.value.id ?? repository.milestoneId,
              AddUpdateMilestoneRequest(
                  stateEvent: MilestoneStateEvent.active));
          repository.milestonesUpdate.value++;
        }).then((value) => handleHttpActionState(value));
        EasyLoading.dismiss();
        break;
      case MilestoneScreenPopupActions.delete:
        showDialog(
          context: context,
          builder: (context) => QuestionMessagePresetsDialog(
            title: 'Delete milestone'.tr,
            text: 'Are you sure?'.tr,
            action: () async {
              _dontReload = true;
              EasyLoading.show();
              await runWithErrorHandlingWithoutState(() async {
                await apiRepository.deleteProjectMilestone(
                    repository.project.value.id ?? repository.projectId,
                    repository.milestone.value.id ?? repository.milestoneId);
                repository.milestonesUpdate.value++;
                Get.back();
              }).then((value) => handleHttpActionState(value));
              EasyLoading.dismiss();
            },
          ),
        );
        break;
    }
  }

  Future<void> onRefresh() async {
    await getMilestone();
    await getIssues();
    await getMR();

    completePerc.value = calcCompletionStatus();
    completePercProgress.value =
        convertRange(0, 100, 0.0, 1, completePerc.value.toDouble());
  }

  int calcCompletionStatus() {
    var it = 0, ic = 0;

    for (var issue in issues) {
      it++;
      if (issue.state == IssueState.closed) {
        ic++;
      }
    }

    if (it == 0) {
      return 0;
    }

    var perc = (100 / it) * ic;

    if (perc > 100) {
      return 100;
    }

    return perc.round().toInt();
  }

  double convertRange(double originalStart, double originalEnd, double newStart,
      double newEnd, double value) {
    double scale = (newEnd - newStart) / (originalEnd - originalStart);
    return newStart + ((value - originalStart) * scale);
  }

  void navigateToIssue(Issue item) {
    repository.issue.value = item;
    Get.toNamed(Routes.issue);
  }

  void navigateToMr(MergeRequest item) {
    repository.mergeRequest.value = item;
    Get.toNamed(Routes.mergeRequest);
  }
}
