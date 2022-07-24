import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/milestones/milestones.dart';
import 'package:gitplus_for_gitlab/modules/project_labels/project_labels.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class EditIssueController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  EditIssueController({
    required this.apiRepository,
    required this.repository,
  });

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Rx<Author> assignee = Author().obs;
  var milestone = ProjectMilestone().obs;
  var labels = <ProjectLabel>[].obs;

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  late PagingResponse<User> _usersRes;
  final _usersFind = DelayedRequest();
  var users = <User>[].obs;

  var _search = "";

  var _page = 0;

  @override
  void onReady() async {
    super.onReady();
    titleController.text = repository.issue.value.title ?? '';
    descriptionController.text = repository.issue.value.description ?? '';
    assignee.value = repository.issue.value.assignee ?? Author();
    milestone.value = repository.issue.value.milestone ?? ProjectMilestone();
    labels.value = List.from(repository.issueLabels);
  }

  @override
  void onClose() {
    _usersFind.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> listUsers(int page) async {
    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _usersRes = await apiRepository
              .listUsers(FindUsersRequest(page: page, search: _search)) ??
          PagingResponse<User>();
      if (page == 1) {
        users.value = initPagingList(_usersRes);
      } else {
        users.addAll(initPagingList(_usersRes));
      }
    });
  }

  void onAssigeeDeleted() {
    assignee.value = Author();
  }

  void onMilestoneDeleted() {
    milestone.value = ProjectMilestone();
  }

  void onDeleteLabelAction(ProjectLabel item) {
    labels.removeWhere((element) => element.id == item.id);
  }

  Future<void> onSave() async {
    List<String> list = [];

    for (var item in labels) {
      list.add(item.name!);
    }

    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.updateProjectIssue(
          repository.project.value.id ?? repository.projectId,
          repository.issue.value.iid ?? repository.issueIid,
          UpdateIssueRequest(
            title: titleController.text,
            description: descriptionController.text,
            assigneeId: assignee.value.id,
            milestoneId: milestone.value.id ?? 0,
            labels: list.join(','),
          ));
      repository.issuesUpdate.value++;
      Get.back();
    }).then((value) {
      handleHttpActionState(value);
    });
    EasyLoading.dismiss();
  }

  void _scrollListener() {
    scrollListener(
        scrollController, _usersRes, (value) => listUsers(value), _page);
  }

  void onUserSearchTextChanged(String s) {
    _usersFind.request(s, (str) async {
      _search = str;
      await runWithErrorHandlingWithoutState(() async {
        _usersRes =
            await apiRepository.listUsers(FindUsersRequest(search: str)) ??
                PagingResponse<User>();
        users.value = initPagingList(_usersRes);
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

  void onShowMilestoneScreen() {
    Get.toNamed(Routes.milestones,
        arguments: MilestonesScreenArgs(onSelected: (val) {
      milestone.value = val;
    }));
  }

  void onNavToLabels() {
    Get.toNamed(
      Routes.labels,
      arguments: ProjectLabelsScreenArgs(
          onSelected: (item) {
            var exist = labels.any((element) => element.id == item.id);
            if (exist) return;
            labels.add(item);
          },
          parentRoute: Routes.editIssue),
    );
  }
}
