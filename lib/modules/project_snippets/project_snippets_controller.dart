import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class ProjectSnippetsController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  ProjectSnippetsController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  late PagingResponse<ProjectSnippet> _snippetsRes;

  var snippets = <ProjectSnippet>[].obs;

  var _page = 0;

  late StreamSubscription _snippetsUpdateSubscription;

  @override
  void onReady() async {
    super.onReady();
    _snippetsUpdateSubscription = repository.snippetsUpdate.listen((val) {
      list();
    });
    list();
  }

  @override
  void onClose() {
    _snippetsUpdateSubscription.cancel();
    scrollController.dispose();
    super.onClose();
  }

  void _handleHttpState<T>(List<T> data, Rx<HttpState> state, int statusCode) {
    if (statusCode == 401) {
      state.value = HttpState.tokenExpired;
      return;
    }
    if (statusCode > 0) {
      state.value = HttpState.error;
      return;
    }
    if (data.isEmpty) {
      state.value = HttpState.empty;
    } else {
      state.value = HttpState.ok;
    }
  }

  Future<void> list() async {
    _page = 0;
    await runWithErrorHandlingWithoutState(() async {
      _snippetsRes = await apiRepository.listProjectSnippets(
              repository.project.value.id!, SnippetsRequest()) ??
          PagingResponse<ProjectSnippet>();
      snippets.value = initPagingList(_snippetsRes);
    }).then((value) {
      _handleHttpState(snippets, state, value);
    });
  }

  Future<void> listMore(int page) async {
    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _snippetsRes = await apiRepository.listProjectSnippets(
              repository.project.value.id!, SnippetsRequest(page: page)) ??
          PagingResponse<ProjectSnippet>();
      if (page == 1) {
        snippets.value = initPagingList(_snippetsRes);
      } else {
        snippets.addAll(initPagingList(_snippetsRes));
      }
    });
  }

  Future<void> _scrollListener() async {
    scrollListener(
        scrollController, _snippetsRes, (value) => listMore(value), _page);
  }

  void onSelected(ProjectSnippet item) {
    repository.snippet.value = item;
    Get.toNamed(Routes.projectSnippet);
  }
}
