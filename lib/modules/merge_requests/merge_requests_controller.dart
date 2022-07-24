import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class MergeRequestsController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  MergeRequestsController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  late PagingResponse<MergeRequest> _mergeRequestsRes;
  late PagingResponse<MergeRequest> _foundMergeRequestsRes;

  var mergeRequests = <MergeRequest>[].obs;
  var foundMergeRequests = <MergeRequest>[].obs;

  var mergeRequestsFilterScope = MergeRequestScope.all.obs;
  var mergeRequestsFilterState = ''.obs;

  final _mergeRequestsFind = DelayedRequest();

  var _page = 0;

  late StreamSubscription _mergeRequestsUpdateSubs;

  @override
  void onReady() async {
    super.onReady();

    _mergeRequestsUpdateSubs = repository.mergeRequestsUpdate.listen((p0) {
      list();
    });

    list();
  }

  @override
  void onClose() {
    scrollController.dispose();
    _mergeRequestsUpdateSubs.cancel();
    _mergeRequestsFind.dispose();
    super.onClose();
  }

  Future<void> list() async {
    String? scope;
    if (mergeRequestsFilterScope.value != MergeRequestScope.all) {
      scope = mergeRequestsFilterScope.value;
    }

    String? state1;
    if (mergeRequestsFilterState.isNotEmpty) {
      state1 = mergeRequestsFilterState.value;
    }

    await runWithErrorHandling(() async {
      _mergeRequestsRes = await apiRepository.listProjectMergeRequests(
              repository.project.value.id!,
              MergeRequestRequest(scope: scope, state: state1)) ??
          PagingResponse<MergeRequest>();
      mergeRequests.value = initPagingList(_mergeRequestsRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) return;
      if (mergeRequests.isEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          state.value = HttpState.empty;
        });
      }
    });
  }

  Future<void> listMore(int page) async {
    String? scope;
    if (mergeRequestsFilterScope.value != MergeRequestScope.all) {
      scope = mergeRequestsFilterScope.value;
    }

    String? state1;
    if (mergeRequestsFilterState.isNotEmpty) {
      state1 = mergeRequestsFilterState.value;
    }

    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _mergeRequestsRes = await apiRepository.listProjectMergeRequests(
              repository.project.value.id!,
              MergeRequestRequest(page: page, scope: scope, state: state1)) ??
          PagingResponse<MergeRequest>();
      if (page == 1) {
        mergeRequests.value = initPagingList(_mergeRequestsRes);
      } else {
        mergeRequests.addAll(initPagingList(_mergeRequestsRes));
      }
    });
  }

  void onSearchTextChanged(String s) {
    _mergeRequestsFind.request(s, (str) async {
      _foundMergeRequestsRes = await apiRepository.listProjectMergeRequests(
              repository.project.value.id!, MergeRequestRequest(search: str)) ??
          PagingResponse<MergeRequest>();
      foundMergeRequests.value = initPagingList(_foundMergeRequestsRes);
    });
  }

  Future<void> _scrollListener() async {
    scrollListener(
        scrollController, _mergeRequestsRes, (value) => listMore(value), _page);
  }

  void onSelected(MergeRequest item) {
    repository.mergeRequest.value = item;
    Get.toNamed(Routes.mergeRequest);
  }

  void onMergeRequestScopeChanged(String value) {
    _page = 0;
    mergeRequestsFilterScope.value = value;
    list();
  }

  void onMergeRequestStateChanged(String value) {
    _page = 0;
    mergeRequestsFilterState.value = value;
    list();
  }

  void onNavToNewMR() {
    Get.toNamed(Routes.createMergeRequest);
  }
}
