import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/project_details/project_details.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  ProjectDetailsController({
    required this.apiRepository,
    required this.repository,
  });

  final storage = Get.find<SPStorage>();

  late StreamSubscription<Project> _refSubscription;
  late StreamSubscription _projectSubscription;

  late PagingResponse<Starrer> _starrersRes;

  var readmeFilename = "".obs;
  var readmeConent = "".obs;
  var starred = false.obs;

  @override
  void onReady() async {
    super.onReady();

    repository.ref.value = repository.project.value.defaultBranch ?? '';

    _refSubscription = repository.project.listen((p0) {
      repository.ref.value = p0.defaultBranch ?? "";
    });

    _projectSubscription = repository.projectUpdate.listen((p0) {
      getProject();
    });

    getProject();
    getReadme();
    listStarrers();
  }

  @override
  void onClose() {
    _refSubscription.cancel();
    _projectSubscription.cancel();
    super.onClose();
  }

  Future<void> getProject() async {
    await runWithErrorHandling(() async {
      repository.project.value = await apiRepository.getProject(
              repository.project.value.id ?? repository.projectId,
              ProjectRequest(license: true)) ??
          Project();
    }).then((value) {
      if (value == 404) {
        CommonWidget.toast('Not found');
        Get.back();
      }
    });
  }

  Future<void> onRefreshAll() async {
    await getProject();
    listStarrers();
    getReadme();
  }

  Future<void> starUnstar() async {
    var id = repository.project.value.id ?? -1;
    if (starred.value) {
      EasyLoading.show();
      await runWithErrorHandlingWithoutState(
          () => apiRepository.unstarProject(id));
      EasyLoading.dismiss();
      starred.value = false;
    } else {
      EasyLoading.show();
      await runWithErrorHandlingWithoutState(
          () => apiRepository.starProject(id));
      EasyLoading.dismiss();
      starred.value = true;
    }
    await getProject();
    await listStarrers();
  }

  Future<void> listStarrers() async {
    await runWithErrorHandling(() async {
      _starrersRes = await apiRepository.listProjectStarrers(
              repository.project.value.id ?? -1,
              StarrersRequest(search: repository.account.value.username)) ??
          PagingResponse<Starrer>();
      var starrers = initPagingList(_starrersRes);
      var exist = starrers.any(
          (element) => element.user?.id == repository.account.value.userId);
      starred.value = exist;
    });
  }

  Future<void> getReadme() async {
    await runWithErrorHandlingWithoutState(() async {
      var rt = await apiRepository.listRepositoryTree(
              repository.project.value.id ?? -1,
              TreeRequest(ref: repository.ref.string)) ??
          PagingResponse<Tree>();

      var rtl = initPagingList(rt);

      var t = rtl.where((element) =>
          element.name!.toLowerCase().contains("readme.md") &&
          element.type == TreeTypes.blob);

      if (t.isEmpty) {
        return;
      }

      var f = t.elementAt(0).path;

      var md = await apiRepository.getFile(repository.project.value.id ?? -1,
          f ?? "", FileRequest(ref: repository.ref.string));

      readmeConent.value = utf8.decode(base64.decode(md!.content ?? ""));
      readmeFilename.value = md.fileName ?? "README.md";
    });
  }

  onSelectedBranch(String value) {
    repository.ref.value = value;
    getReadme();
  }

  onPopupSelected(ProjectDetailsScreenPopup value, context) {
    switch (value) {
      case ProjectDetailsScreenPopup.edit:
        Get.toNamed(Routes.editProject);
        break;
      case ProjectDetailsScreenPopup.share:
        Share.share(repository.project.value.webUrl!);
        break;
      case ProjectDetailsScreenPopup.webUrl:
        launch(repository.project.value.webUrl!);
        break;
      case ProjectDetailsScreenPopup.delete:
        showDialog(
          context: context,
          builder: (context) => QuestionMessagePresetsDialog(
            title: 'Delete project'.tr,
            text:
                'This project is NOT a fork. This process deletes the project repository and all related resources.\n\nAre you absolutely sure?'
                    .tr,
            action: () async {
              EasyLoading.show();
              await runWithErrorHandlingWithoutState(() async {
                await apiRepository.deleteProject(repository.project.value.id!);
                repository.projectsUpdate.value++;
                Get.back();
              }).then((value) => handleHttpActionState(value));
              EasyLoading.dismiss();
            },
          ),
        );
        break;
    }
  }
}
