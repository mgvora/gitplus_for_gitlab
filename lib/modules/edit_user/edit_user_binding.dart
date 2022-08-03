import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygit/api/api.dart';
import 'package:mygit/shared/shared.dart';

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
