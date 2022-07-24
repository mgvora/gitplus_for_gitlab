import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/milestones/milestones.dart';
import 'package:gitplus_for_gitlab/modules/project_labels/project_labels.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class CreateIssueController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  CreateIssueController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  late PagingResponse<User> _usersRes;
  final _usersFind = DelayedRequest();

  var assignee = Author().obs;
  var users = <User>[].obs;
  var milestone = ProjectMilestone().obs;
  var labels = <ProjectLabel>[].obs;

  var _search = "";
  var _page = 0;

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final dueDateController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onClose() {
    scrollController.dispose();
    titleController.dispose();
    dueDateController.dispose();
    descriptionController.dispose();
    _usersFind.dispose();
    super.onClose();
  }

  Future<void> onSave() async {
    List<String> list = [];

    for (var item in labels) {
      list.add(item.name!);
    }

    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.addProjectIssue(
          repository.project.value.id!,
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
      if (value > 0) CommonWidget.toast(CommonConstants.errorMessage);
    });
    EasyLoading.dismiss();
  }

  Future<void> listUsers(int page) async {
    _page = page;
    runWithErrorHandlingWithoutState(() async {
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

  void onUserSelected(User item) {
    assignee.value = Author(
      id: item.id,
      name: item.name,
      avatarUrl: item.avatarUrl,
      webUrl: item.webUrl,
    );
  }

  void onUserSearchTextChanged(String s) {
    _usersFind.request(s, (str) async {
      _search = str;
      runWithErrorHandlingWithoutState(() async {
        _usersRes =
            await apiRepository.listUsers(FindUsersRequest(search: str)) ??
                PagingResponse<User>();
        users.value = initPagingList(_usersRes);
      });
    });
  }

  void onDeleteLabelAction(ProjectLabel item) {
    labels.removeWhere((element) => element.id == item.id);
  }

  void _scrollListener() {
    scrollListener(
        scrollController, _usersRes, (value) => listUsers(value), _page);
  }

  void onNavToMilestone() {
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
          parentRoute: Routes.createIssue),
    );
  }
}
