import 'dart:async';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class AccountsController extends GetxController {
  final ApiRepository apiRepository;
  final Repository repository;

  AccountsController({
    required this.apiRepository,
    required this.repository,
  });

  var accounts = <AppAccount>[].obs;
  var account = AppAccount().obs;
  var defaultId = 0.obs;
  var str = ''.obs;

  final _storage = Get.find<SecureStorage>();
  final storage = Get.find<SPStorage>();

  @override
  void onReady() async {
    super.onReady();
    accounts.value = _storage.getAccounts();
    defaultId.value = _storage.getDefaultAccount().userId!;
  }

  onAddClicked() async {
    Get.toNamed(Routes.auth);
  }

  onAccountSelected(AppAccount item) {
    account.value = AppAccount.fromJson(item.toJson());
    Get.toNamed(Routes.accounts + Routes.accountDetails);
  }

  onRemoveAccount() async {
    var id = _storage.getDefaultAccount().userId;
    await _storage.removeAccount(account.value);
    accounts.value = _storage.getAccounts();
    if (account.value.userId == id) {
      if (accounts.isNotEmpty) {
        onSetDefault(accounts[0]);
      } else {
        Get.offAllNamed(Routes.auth);
      }
    } else {
      Get.back();
    }
  }

  Future<void> onSetDefault(AppAccount account) async {
    defaultId.value = account.userId!;
    await _storage.setDefaultAccount(account);
    repository.account.value =
        AppAccount.fromJson(_storage.getDefaultAccount().toJson());
  }

  onEditUser() async {
    Get.toNamed(Routes.editUser);
  }
}
