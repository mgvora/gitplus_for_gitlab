import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'accounts_controller.dart';

class AccountsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountsController>(
        () => AccountsController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
