import 'dart:async';
import 'package:mygit/api/api.dart';
import 'package:mygit/models/models.dart';
import 'package:mygit/shared/shared.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EditUserController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;
  //User user;

  EditUserController({
    required this.apiRepository,
    required this.repository,
    //required this.user,
  });

  var accounts = <AppAccount>[].obs;
  var account = AppAccount().obs;
  var secureStorage = Get.find<SecureStorage>();

  var defaultId = 0.obs;
  var str = ''.obs;

  var stateAll = HttpState.loading.obs;
  var allProjects = <Project>[].obs;

  final _storage = Get.find<SecureStorage>();
  final storage = Get.find<SPStorage>();

  var countAcc = 0;
  var countProjects = 0.obs;
  var countPersonProjects = 0.obs;

  @override
  void onInit() {
    account.value = _storage.getDefaultAccount();
    defaultId.value = _storage.getDefaultAccount().userId!;

    listAllProjects();
    listPersonalProjects();
    super.onInit();
  }

  Future<void> listPersonalProjects() async {
    await runWithErrorHandlingWithoutState(() async {
      var all = await apiRepository.listProjects(ProjectsRequest(
              visibility: "private",
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      countPersonProjects.value = all.total ?? 0;
    });
  }

  Future<void> listAllProjects() async {
    await runWithErrorHandlingWithoutState(() async {
      stateAll.value = HttpState.loading;
      var all = await apiRepository.listProjects(ProjectsRequest(
              membership: true,
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      countProjects.value = all.total ?? 0;
    });
  }

  @override
  void onReady() async {
    countAcc = secureStorage.getAccounts().length;
    super.onReady();
  }

  // Future<void> putAvatar() async {
  //
  // }
}
