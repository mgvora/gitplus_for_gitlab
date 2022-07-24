import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class IssueRelatedMergeRequestsController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  IssueRelatedMergeRequestsController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  late PagingResponse<MergeRequest> _requestsRes;

  var requests = <MergeRequest>[].obs;

  var _page = 0;

  @override
  void onReady() async {
    super.onReady();
    listRequests(1);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> listRequests(int page) async {
    _page = page;
    _requestsRes = await apiRepository.listIssueRelatedMergeRequests(
            repository.project.value.id!, repository.issue.value.iid!) ??
        PagingResponse<MergeRequest>();
    if (page == 1) {
      requests.value = initPagingList(_requestsRes);
    } else {
      requests.addAll(initPagingList(_requestsRes));
    }
  }

  void _scrollListener() {
    scrollListener(
        scrollController, _requestsRes, (value) => listRequests(value), _page);
  }

  void onSelected(MergeRequest item) {
    repository.mergeRequest.value = item;
    Get.toNamed(Routes.mergeRequest);
  }
}
