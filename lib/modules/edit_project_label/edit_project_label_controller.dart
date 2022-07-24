import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class EditProjectLabelController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  EditProjectLabelController({
    required this.apiRepository,
    required this.repository,
  });

  var labels = <ProjectLabel>[].obs;

  final GlobalKey<FormState> editLabelFormKey = GlobalKey<FormState>();
  final editNameController = TextEditingController();
  final editDescriptionController = TextEditingController();

  var editName = "".obs;
  var editColor = "".obs;

  @override
  void onReady() {
    editNameController.text = repository.label.value.name ?? '';
    editDescriptionController.text = repository.label.value.description ?? '';
    editName.value = repository.label.value.name ?? '';
    editColor.value = repository.label.value.color ?? '';
    super.onReady();
  }

  @override
  void onClose() {
    // editNameController.dispose();
    // editDescriptionController.dispose();
    super.onClose();
  }

  void editNameChanged(String value) => editName.value = value;

  void onEditColorChanged(Color c) {
    editColor.value = '#' + colorToHex(c, enableAlpha: false);
  }

  Future<void> onUpdateLabel() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.updateProjectLabel(
          repository.project.value.id ?? repository.projectId,
          repository.label.value.id!,
          UpdateProjectLabelRequest(
            newName: editNameController.text,
            description: editDescriptionController.text,
            color: editColor.value,
          ));
      Get.back();
      repository.labelsUpdate.value++;
    });
    EasyLoading.dismiss();
  }

  Future<void> onDeleteLabel() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.deleteProjectLabel(
          repository.project.value.id ?? repository.projectId,
          repository.label.value.id!);
      Get.back();
      repository.labelsUpdate.value++;
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }
}
