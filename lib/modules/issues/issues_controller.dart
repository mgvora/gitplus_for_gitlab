import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class IssuesController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  IssuesController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);
  late ScrollController scrollFoundController = ScrollController()
    ..addListener(_scrollFoundListener);

  final _issuesFind = DelayedRequest();

  late PagingResponse<Issue> _issuesRes;
  late PagingResponse<Issue> _foundIssuesRes;

  var issues = <Issue>[].obs;
  var foundIssues = <Issue>[].obs;

  var issuesFilterScope = IssuesScope.all.obs;
  var issuesFilterState = ''.obs;

  var _page = 0;
  var _pageFound = 0;
  var _searchString = "";

  late StreamSubscription _issuesUpdateSub;

  @override
  void onReady() async {
    super.onReady();
    _issuesUpdateSub = repository.issuesUpdate.listen((p0) {
      list();
    });

    list();
  }

  @override
  void onClose() {
    scrollController.dispose();
    scrollFoundController.dispose();
    _issuesUpdateSub.cancel();
    _issuesFind.dispose();
    super.onClose();
  }

  Future<void> list() async {
    _page = 0;
    _pageFound = 0;
    _searchString = '';

    String? scope;
    if (issuesFilterScope.value != IssuesScope.all) {
      scope = issuesFilterScope.value;
    }

    String? state1;
    if (issuesFilterState.isNotEmpty) {
      state1 = issuesFilterState.value;
    }

    await runWithErrorHandling(() async {
      _issuesRes = await apiRepository.listProjectIssues(
              repository.project.value.id!,
              IssuesRequest(state: state1, scope: scope)) ??
          PagingResponse<Issue>();
      issues.value = initPagingList(_issuesRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) return;
      if (issues.isEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          state.value = HttpState.empty;
        });
      }
    });
  }

  Future<void> listMore(int page) async {
    String? scope;
    if (issuesFilterScope.value != IssuesScope.all) {
      scope = issuesFilterScope.value;
    }

    String? state1;
    if (issuesFilterState.isNotEmpty) {
      state1 = issuesFilterState.value;
    }

    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _issuesRes = await apiRepository.listProjectIssues(
              repository.project.value.id!,
              IssuesRequest(page: page, state: state1, scope: scope)) ??
          PagingResponse<Issue>();
      if (page == 1) {
        issues.value = initPagingList(_issuesRes);
      } else {
        issues.addAll(initPagingList(_issuesRes));
      }
    });
  }

  Future<void> listMoreFound(int page) async {
    _pageFound = page;
    await runWithErrorHandlingWithoutState(() async {
      _foundIssuesRes = await apiRepository.listProjectIssues(
              repository.project.value.id!,
              IssuesRequest(search: _searchString, page: page)) ??
          PagingResponse<Issue>();
      if (page == 1) {
        foundIssues.value = initPagingList(_foundIssuesRes);
      } else {
        foundIssues.addAll(initPagingList(_foundIssuesRes));
      }
    });
  }

  Future<void> _scrollListener() async {
    scrollListener(
        scrollController, _issuesRes, (value) => listMore(value), _page);
  }

  Future<void> _scrollFoundListener() async {
    scrollListener(scrollFoundController, _foundIssuesRes,
        (value) => listMoreFound(value), _pageFound);
  }

  void onNavToDetails(Issue item) {
    repository.issue.value = item;
    Get.toNamed(Routes.issue);
  }

  void onNavToNewIssue() {
    Get.toNamed(Routes.createIssue);
  }

  void onSearchIssuesTextChanged(String s) {
    _page = 0;
    _pageFound = 0;
    _searchString = s;
    _issuesFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        _foundIssuesRes = await apiRepository.listProjectIssues(
                repository.project.value.id!, IssuesRequest(search: str)) ??
            PagingResponse<Issue>();
        foundIssues.value = initPagingList(_foundIssuesRes);
      });
    });
  }

  void onIssuesStateChanged(String value) {
    _page = 0;
    _pageFound = 0;
    issuesFilterState.value = value;
    list();
  }

  void onIssuesScopeChanged(String value) {
    _page = 0;
    _pageFound = 0;
    issuesFilterScope.value = value;
    list();
  }
}
