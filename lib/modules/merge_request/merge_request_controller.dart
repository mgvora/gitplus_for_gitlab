import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'merge_request_screen.dart';

class MergeRequestController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  MergeRequestController({
    required this.apiRepository,
    required this.repository,
  });

  late StreamSubscription _mrUpdateSubscription;

  var _dontReloadMR = false;

  @override
  void onReady() async {
    super.onReady();

    if (repository.loadProjectRequired.value) {
      getProject();
    }

    _mrUpdateSubscription = repository.mergeRequestsUpdate.listen((p0) async {
      if (_dontReloadMR) return;
      await getMergeRequest();
    });
    await getMergeRequest();
  }

  @override
  void onClose() {
    _mrUpdateSubscription.cancel();
    super.onClose();
  }

  Future<void> getProject() async {
    await runWithErrorHandlingWithoutState(() async {
      repository.project.value = await apiRepository.getProject(
              repository.projectId, ProjectRequest()) ??
          Project();
    });
  }

  Future<void> getMergeRequest() async {
    await runWithErrorHandlingWithoutState(() async {
      repository.mergeRequest.value = await apiRepository.getMergeRequest(
              repository.project.value.id ?? repository.projectId,
              repository.mergeRequest.value.iid ??
                  repository.mergeRequestIid) ??
          MergeRequest();
    });
  }

  onPopupSelected(MergeRequestScreenPopupActions value, context) async {
    switch (value) {
      case MergeRequestScreenPopupActions.edit:
        Get.toNamed(Routes.editMergeRequest);
        break;
      case MergeRequestScreenPopupActions.reopen:
        EasyLoading.show();
        await runWithErrorHandlingWithoutState(() async {
          await apiRepository.updateMergeRequest(
              repository.project.value.id ?? repository.projectId,
              repository.mergeRequest.value.iid ?? repository.mergeRequestIid,
              UpdateMRRequest(stateEvent: MergeRequestStateEvent.reopen));
          repository.mergeRequestsUpdate.value++;
        }).then((value) => handleHttpActionState(value));
        EasyLoading.dismiss();
        break;
      case MergeRequestScreenPopupActions.close:
        EasyLoading.show();
        await runWithErrorHandlingWithoutState(() async {
          await apiRepository.updateMergeRequest(
              repository.project.value.id ?? repository.projectId,
              repository.mergeRequest.value.iid ?? repository.mergeRequestIid,
              UpdateMRRequest(stateEvent: MergeRequestStateEvent.close));
          repository.mergeRequestsUpdate.value++;
        }).then((value) => handleHttpActionState(value));

        EasyLoading.dismiss();
        break;
      case MergeRequestScreenPopupActions.delete:
        showDialog(
          context: context,
          builder: (context) => QuestionMessagePresetsDialog(
            title: 'Delete merge request'.tr,
            text: 'Are you sure?'.tr,
            action: () async {
              _dontReloadMR = true;
              EasyLoading.show();
              await runWithErrorHandlingWithoutState(() async {
                await apiRepository.deleteMergeRequest(
                    repository.project.value.id ?? repository.projectId,
                    repository.mergeRequest.value.iid ??
                        repository.mergeRequestIid);
                repository.mergeRequestsUpdate.value++;
                Get.back();
              }).then((value) => handleHttpActionState(value));
              EasyLoading.dismiss();
            },
          ),
        );
        break;
      case MergeRequestScreenPopupActions.share:
        Share.share(repository.mergeRequest.value.webUrl!);
        break;
      case MergeRequestScreenPopupActions.openWeb:
        launchUrl(Uri.parse((repository.mergeRequest.value.webUrl!)));
        break;
    }
  }

  onRefresh() async {
    await getMergeRequest();
  }
}
