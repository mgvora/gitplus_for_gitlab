import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

import 'create_project_snippet_screen.dart';

class CreateProjectSnippetController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  CreateProjectSnippetController({
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

  void onSelectedVisibility(SnippetVisibilityItemItem? value) {
    if (value == null) {
      return;
    }
  }

  void onVisibilityChanged(String value) {
    visibility.value = value;
  }

  Future<void> add() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.addProjectSnippet(
          repository.project.value.id!,
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
