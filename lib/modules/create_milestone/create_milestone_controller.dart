import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class CreateMilestoneController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  CreateMilestoneController({
    required this.apiRepository,
    required this.repository,
  });

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dueDateController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onClose() {
    titleController.dispose();
    dueDateController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> addProjectMilestone() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.addProjectMilestone(
          repository.project.value.id!,
          AddUpdateMilestoneRequest(
            title: titleController.text,
            description: descriptionController.text,
            dueDate: dueDateController.text,
          ));
      repository.milestonesUpdate.value++;
      Get.back();
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }
}
