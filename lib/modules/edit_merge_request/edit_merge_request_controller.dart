import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class EditMergeRequestController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  EditMergeRequestController({
    required this.apiRepository,
    required this.repository,
  });

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  var assignee = Author().obs;
  var branch = ''.obs;

  late ScrollController usersScrollController = ScrollController()
    ..addListener(_usersScrollListener);
  late ScrollController branchesScrollController = ScrollController()
    ..addListener(_branchesScrollListener);

  late PagingResponse<User> _usersRes;
  late PagingResponse<Branch> _branchesRes;

  final _usersFind = DelayedRequest();
  final _branchesFind = DelayedRequest();

  var users = <User>[].obs;
  var branches = <Branch>[].obs;

  var _usersSearch = "";
  var _branchesSearch = "";

  var _usersPage = 0;
  var _branchesPage = 0;

  @override
  void onReady() async {
    super.onReady();
    titleController.text = repository.mergeRequest.value.title ?? '';
    descriptionController.text =
        repository.mergeRequest.value.description ?? '';
    assignee.value = repository.mergeRequest.value.assignee ?? Author();
    branch.value = repository.mergeRequest.value.targetBranch ?? '';
  }

  @override
  void onClose() {
    usersScrollController.dispose();
    branchesScrollController.dispose();
    _usersFind.dispose();
    _branchesFind.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> listUsers(int page) async {
    _usersPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _usersRes = await apiRepository
              .listUsers(FindUsersRequest(page: page, search: _usersSearch)) ??
          PagingResponse<User>();
      if (page == 1) {
        users.value = initPagingList(_usersRes);
      } else {
        users.addAll(initPagingList(_usersRes));
      }
    });
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

  void onAssigeeDeleted() {
    assignee.value = Author();
  }

  Future<void> onSave() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.updateMergeRequest(
          repository.project.value.id ?? repository.projectId,
          repository.mergeRequest.value.iid ?? repository.mergeRequestIid,
          UpdateMRRequest(
            title: titleController.text,
            description: descriptionController.text,
            targetBranch: branch.value,
            assigneeId: assignee.value.id ?? 0,
          ));
      repository.mergeRequestsUpdate.value++;
      Get.back();
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }

  void _usersScrollListener() {
    scrollListener(usersScrollController, _usersRes,
        (value) => listUsers(value), _usersPage);
  }

  void _branchesScrollListener() {
    scrollListener(branchesScrollController, _branchesRes,
        (value) => listBranches(value), _branchesPage);
  }

  void onUserSearchTextChanged(String s) {
    _usersFind.request(s, (str) async {
      _usersSearch = str;
      await runWithErrorHandlingWithoutState(() async {
        _usersRes =
            await apiRepository.listUsers(FindUsersRequest(search: str)) ??
                PagingResponse<User>();
        users.value = initPagingList(_usersRes);
      });
    });
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

  void onUserSelected(User item) {
    assignee.value = Author(
      id: item.id,
      name: item.name,
      avatarUrl: item.avatarUrl,
      webUrl: item.webUrl,
    );
  }

  void onBranchSelected(Branch item) {
    branch.value = item.name!;
  }
}
