import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/project_snippet/project_snippet_screen.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectSnippetController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  ProjectSnippetController({
    required this.apiRepository,
    required this.repository,
  });

  final spStorage = Get.find<SPStorage>();

  late StreamSubscription _snippetUpdateSubscription;

  @override
  void onReady() async {
    super.onReady();

    _snippetUpdateSubscription = repository.snippetsUpdate.listen((p0) {
      onRefresh();
    });

    getContent();
  }

  @override
  void onClose() {
    _snippetUpdateSubscription.cancel();
    super.onClose();
  }

  Future<void> getSnippet() async {
    repository.snippet.value = await apiRepository.getProjectSnippet(
            repository.project.value.id!, repository.snippet.value.id!) ??
        ProjectSnippet();
  }

  Future<void> getContent() async {
    repository.snippetContent.value =
        await apiRepository.getProjectSnippetContent(
                repository.project.value.id!, repository.snippet.value.id!) ??
            '';
  }

  Future<void> onRefresh() async {
    await getSnippet();
    await getContent();
  }

  onPopupSelected(ProjectSnippetScreenPopupActions value, context) {
    switch (value) {
      case ProjectSnippetScreenPopupActions.edit:
        Get.toNamed(Routes.editSnippet);
        break;
      case ProjectSnippetScreenPopupActions.delete:
        showDialog(
          context: context,
          builder: (context) => QuestionMessagePresetsDialog(
            title: 'Delete snippet'.tr,
            text: 'Are you sure?'.tr,
            action: () async {
              EasyLoading.show();
              await runWithErrorHandlingWithoutState(() async {
                await apiRepository.deleteProjectSnippet(
                    repository.project.value.id!, repository.snippet.value.id!);
                repository.snippetsUpdate.value++;
                Get.back();
              }).then((value) => handleHttpActionState(value));
              EasyLoading.dismiss();
            },
          ),
        );
        break;
      case ProjectSnippetScreenPopupActions.share:
        Share.share(repository.snippet.value.webUrl ?? '');
        break;
      case ProjectSnippetScreenPopupActions.web:
        launch(repository.snippet.value.webUrl!);
        break;
    }
  }
}
