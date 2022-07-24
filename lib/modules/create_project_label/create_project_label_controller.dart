import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class CreateProjectLabelController extends GetxController with HttpController {
  final ApiRepository apiRepository;
  final Repository repository;

  CreateProjectLabelController({
    required this.apiRepository,
    required this.repository,
  });

  final GlobalKey<FormState> addLabelFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  var addName = "New Label".tr.obs;
  var addColor = "".obs;

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void addNameChanged(String value) {
    if (value.isEmpty) {
      addName.value = "New Label".tr;
      return;
    }
    addName.value = value;
  }

  void onAddColorChanged(Color c) {
    addColor.value = '#' + colorToHex(c, enableAlpha: false);
  }

  Future<void> onAddLabel() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.createProjectLabel(
          repository.project.value.id!,
          CreateLabelRequest(
            name: nameController.text,
            description: descriptionController.text,
            color: addColor.value,
          ));
      Get.back();
      repository.labelsUpdate.value++;
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }
}
