import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class ProjectLabelsController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  ProjectLabelsController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);
  late ScrollController scrollFoundController = ScrollController()
    ..addListener(_scrollFoundListener);

  late PagingResponse<ProjectLabel> _labelsRes;
  late PagingResponse<ProjectLabel> _foundRes;

  var labels = <ProjectLabel>[].obs;
  var found = <ProjectLabel>[].obs;

  var labelToEdit = ProjectLabel();

  final _labelsFind = DelayedRequest();

  var _page = 0;
  var _foundPage = 0;

  late StreamSubscription _updateLabelsSub;

  @override
  void onReady() async {
    super.onReady();
    list();
    _updateLabelsSub = repository.labelsUpdate.listen((p0) {
      list();
    });
  }

  @override
  void onClose() {
    _updateLabelsSub.cancel();

    scrollController.dispose();
    scrollFoundController.dispose();

    _labelsFind.dispose();
    super.onClose();
  }

  void setPage(int value) {
    _page = value;
  }

  Future<void> list() async {
    _page = 0;
    _foundPage = 0;
    await runWithErrorHandling(() async {
      _labelsRes = await apiRepository.listProjectLabels(
              repository.project.value.id!, ProjectLabelsRequest()) ??
          PagingResponse<ProjectLabel>();
      labels.value = initPagingList(_labelsRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) return;
      if (labels.isEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          state.value = HttpState.empty;
        });
      }
    });
  }

  Future<void> listFound() async {
    _page = 0;
    _foundPage = 0;
    await runWithErrorHandling(() async {
      _foundRes = await apiRepository.listProjectLabels(
              repository.project.value.id!, ProjectLabelsRequest()) ??
          PagingResponse<ProjectLabel>();
      found.value = initPagingList(_labelsRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) return;
      if (found.isEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          state.value = HttpState.empty;
        });
      }
    });
  }

  Future<void> listMore(int page) async {
    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _labelsRes = await apiRepository.listProjectLabels(
              repository.project.value.id!, ProjectLabelsRequest(page: page)) ??
          PagingResponse<ProjectLabel>();
      if (page == 1) {
        labels.value = initPagingList(_labelsRes);
      } else {
        labels.addAll(initPagingList(_labelsRes));
      }
    });
  }

  Future<void> listMoreFound(int page) async {
    _foundPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _foundRes = await apiRepository.listProjectLabels(
              repository.project.value.id!, ProjectLabelsRequest(page: page)) ??
          PagingResponse<ProjectLabel>();
      if (page == 1) {
        found.value = initPagingList(_foundRes);
      } else {
        found.addAll(initPagingList(_foundRes));
      }
    });
  }

  Future<void> _scrollListener() async {
    scrollListener(
        scrollController, _labelsRes, (value) => listMore(value), _page);
  }

  Future<void> _scrollFoundListener() async {
    scrollListener(scrollFoundController, _foundRes,
        (value) => listMoreFound(value), _foundPage);
  }

  void navigateToEditScreen(ProjectLabel item) {
    repository.label.value = item;
    Get.toNamed(Routes.editLabel);
  }

  void navigateToAddScreen() {
    Get.toNamed(Routes.createLabel);
  }

  void onSearchIssuesTextChanged(String s) {
    _page = 0;
    _foundPage = 0;
    _labelsFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        _foundRes = await apiRepository.listProjectLabels(
                repository.project.value.id!,
                ProjectLabelsRequest(search: str)) ??
            PagingResponse<ProjectLabel>();
        found.value = initPagingList(_foundRes);
      });
    });
  }
}
