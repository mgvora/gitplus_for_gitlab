import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/api_repository.dart';
import '../../shared/data/repository.dart';
import 'edit_user_controller.dart';

class EditUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditUserController>(
        () => EditUserController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
