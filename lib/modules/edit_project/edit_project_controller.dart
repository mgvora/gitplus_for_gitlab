import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class EditProjectController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  EditProjectController({
    required this.apiRepository,
    required this.repository,
  });

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final pathController = TextEditingController();
  final descriptionController = TextEditingController();

  late ScrollController branchesScrollController = ScrollController()
    ..addListener(_branchesScrollListener);

  var visibility = GitLabVisibility.private.obs;
  var branch = ''.obs;
  var branches = <Branch>[].obs;

  late PagingResponse<Branch> _branchesRes;

  final _branchesFind = DelayedRequest();

  var _branchesSearch = "";
  var _branchesPage = 0;

  @override
  void onClose() {
    titleController.dispose();
    pathController.dispose();
    descriptionController.dispose();
    branchesScrollController.dispose();
    _branchesFind.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    visibility.value = repository.project.value.visibility!;
    super.onInit();
  }

  @override
  void onReady() {
    titleController.text = repository.project.value.name ?? '';
    pathController.text = repository.project.value.path ?? '';
    descriptionController.text = repository.project.value.description ?? '';
    branch.value = repository.project.value.defaultBranch ?? '';
    super.onReady();
  }

  void onVisibilityChanged(String value) {
    visibility.value = value;
  }

  Future<void> save() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.updateProject(
          repository.project.value.id ?? repository.projectId,
          CreateProjectRequest(
            name: titleController.text,
            path: pathController.text,
            description: descriptionController.text,
            visibility: visibility.value,
            defaultBranch: branch.value,
          ));
      repository.projectsUpdate.value++;
      repository.projectUpdate.value++;
      Get.back();
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }

  void onBranchSearchTextChanged(String s) {
    _branchesFind.request(s, (str) async {
      _branchesSearch = str;
      await runWithErrorHandlingWithoutState(() async {
        _branchesRes = await apiRepository.listBranches(
                repository.project.value.id ?? repository.projectId,
                BranchesRequest(search: str)) ??
            PagingResponse<Branch>();
        branches.value = initPagingList(_branchesRes);
      });
    });
  }

  void onBranchSelected(Branch item) {
    branch.value = item.name!;
  }

  void _branchesScrollListener() {
    scrollListener(branchesScrollController, _branchesRes,
        (value) => listBranches(value), _branchesPage);
  }

  Future<void> listBranches(int page) async {
    _branchesPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _branchesRes = await apiRepository.listBranches(
              repository.project.value.id ?? repository.projectId,
              BranchesRequest(page: page, search: _branchesSearch)) ??
          PagingResponse<Branch>();
      if (page == 1) {
        branches.value = initPagingList(_branchesRes);
      } else {
        branches.addAll(initPagingList(_branchesRes));
      }
    });
  }
}
