import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class CreateProjectController extends GetxController with HttpController {
  final ApiRepository apiRepository;
  final Repository repository;

  CreateProjectController({
    required this.apiRepository,
    required this.repository,
  });

  var name = "".obs;
  var visibility = GitLabVisibility.private.obs;
  var visibilityIndex = 0.obs;

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  void nameChanged(String value) => name.value = value;

  void onVisibilityChanged(String value) {
    visibility.value = value;
  }

  Future<void> onSubmit() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      if (Get.previousRoute == Routes.projects) {
        await apiRepository.createProject(CreateProjectRequest(
          name: nameController.value.text,
          description: descriptionController.value.text,
        ));
      } else {
        await apiRepository.createProject(CreateProjectRequest(
          name: nameController.value.text,
          namespaceId: repository.group.value.id.toString(),
          description: descriptionController.value.text,
        ));
      }

      repository.projectsUpdate.value++;
      Get.until((route) => route.settings.name == Get.previousRoute);
    }).then((value) {
      handleHttpActionState(value);
    });
    EasyLoading.dismiss();
  }
}
