import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class MilestonesController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  MilestonesController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);
  late ScrollController scrollFoundController = ScrollController()
    ..addListener(_scrollFoundListener);

  late PagingResponse<ProjectMilestone> _milestonesRes;
  late PagingResponse<ProjectMilestone> _foundMilestonesRes;

  final _issuesFind = DelayedRequest();

  var milestones = <ProjectMilestone>[].obs;
  var foundMilestones = <ProjectMilestone>[].obs;

  var filterScope = MergeRequestScope.all.obs;
  var filterState = ''.obs;

  var _page = 0;

  late StreamSubscription _milestonesUpdateSubs;

  @override
  void onReady() async {
    super.onReady();
    _milestonesUpdateSubs = repository.milestonesUpdate.listen((p0) {
      list();
    });
    list();
  }

  @override
  void onClose() {
    scrollController.dispose();
    scrollFoundController.dispose();
    _issuesFind.dispose();
    _milestonesUpdateSubs.cancel();
    super.onClose();
  }

  Future<void> list() async {
    String? state1;
    if (filterState.isNotEmpty) {
      state1 = filterState.value;
    }

    await runWithErrorHandling(() async {
      _milestonesRes = await apiRepository.listProjectMilestones(
              repository.project.value.id!, MilestonesRequest(state: state1)) ??
          PagingResponse<ProjectMilestone>();
      milestones.value = initPagingList(_milestonesRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) return;
      if (milestones.isEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          state.value = HttpState.empty;
        });
      }
    });
  }

  Future<void> listMore(int page) async {
    String? state1;
    if (filterState.isNotEmpty) {
      state1 = filterState.value;
    }

    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _milestonesRes = await apiRepository.listProjectMilestones(
              repository.project.value.id!,
              MilestonesRequest(page: page, state: state1)) ??
          PagingResponse<ProjectMilestone>();
      if (page == 1) {
        milestones.value = initPagingList(_milestonesRes);
      } else {
        milestones.addAll(initPagingList(_milestonesRes));
      }
    });
  }

  Future<void> _scrollListener() async {
    scrollListener(
        scrollController, _milestonesRes, (value) => listMore(value), _page);
  }

  Future<void> _scrollFoundListener() async {
    scrollListener(scrollFoundController, _foundMilestonesRes,
        (value) => listMore(value), _page);
  }

  void onSearchIssuesTextChanged(String s) {
    _issuesFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        _foundMilestonesRes = await apiRepository.listProjectMilestones(
                repository.project.value.id!, MilestonesRequest(search: str)) ??
            PagingResponse<ProjectMilestone>();
        foundMilestones.value = initPagingList(_foundMilestonesRes);
      });
    });
  }

  void onSelected(ProjectMilestone item) {
    _page = 0;
    repository.milestone.value = item;
    Get.toNamed(Routes.milestone);
  }

  void filterStateChanged(String value) {
    _page = 0;
    filterState.value = value;
    list();
  }
}
