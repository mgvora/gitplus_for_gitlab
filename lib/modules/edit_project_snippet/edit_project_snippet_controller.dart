import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class EditProjectSnippetController extends GetxController with HttpController {
  final ApiRepository apiRepository;
  final Repository repository;

  EditProjectSnippetController({
    required this.apiRepository,
    required this.repository,
  });

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final filenameController = TextEditingController();
  final codeController = TextEditingController();

  var visibility = GitLabVisibility.private.obs;

  @override
  void onClose() {
    titleController.dispose();
    filenameController.dispose();
    codeController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    codeController.text = repository.snippetContent.value;
    visibility.value = repository.snippet.value.visibility!;
    super.onInit();
  }

  @override
  void onReady() {
    titleController.text = repository.snippet.value.title ?? '';
    filenameController.text = repository.snippet.value.fileName ?? '';
    super.onReady();
  }

  void onVisibilityChanged(String value) {
    visibility.value = value;
  }

  Future<void> save() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.updateProjectSnippet(
          repository.project.value.id ?? repository.projectId,
          repository.snippet.value.id!,
          AddUpdateSnippetRequest(
              title: titleController.text,
              fileName: filenameController.text,
              visibility: visibility.value,
              content: codeController.text));
      repository.snippetsUpdate.value++;
      Get.back();
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }
}
