import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class EditIssueNoteController extends GetxController with HttpController {
  final ApiRepository apiRepository;
  final Repository repository;

  EditIssueNoteController({
    required this.apiRepository,
    required this.repository,
  });

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final bodyController = TextEditingController();

  @override
  void onInit() {
    bodyController.text = repository.note.value.body ?? '';
    super.onInit();
  }

  @override
  void onClose() {
    bodyController.dispose();
    super.onClose();
  }

  Future<void> save() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.updateProjectIssueNote(
        repository.project.value.id ?? repository.projectId,
        repository.issue.value.iid ?? repository.issueIid,
        repository.note.value.id!,
        UpdateIssueNoteRequest(body: bodyController.text),
      );
      repository.note.value = Note(body: bodyController.text);
      repository.issueNotesUpdate.value++;
      Get.back();
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }

  Future<void> delete(context) async {
    showDialog(
      context: context,
      builder: (context) => QuestionMessagePresetsDialog(
        title: 'Delete note'.tr,
        text: 'Are you sure?'.tr,
        action: () async {
          EasyLoading.show();
          await runWithErrorHandlingWithoutState(() async {
            await apiRepository.deleteProjectIssueNote(
              repository.project.value.id ?? repository.projectId,
              repository.issue.value.iid ?? repository.issueIid,
              repository.note.value.id!,
            );
            repository.issueNotesUpdate.value++;
            Get.back();
          }).then((value) => handleHttpActionState(value));
          EasyLoading.dismiss();
        },
      ),
    );
  }
}
