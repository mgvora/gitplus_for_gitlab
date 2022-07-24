import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/api/utils.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class ProjectActivityController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  ProjectActivityController({
    required this.apiRepository,
    required this.repository,
  });

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  late PagingResponse<Event> _eventsRes;

  var events = <Event>[].obs;

  var _page = 0;

  @override
  void onReady() {
    super.onReady();
    listActivities();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> listActivities() async {
    await runWithErrorHandling(() async {
      _eventsRes = await apiRepository.listProjectEvents(
              repository.project.value.id!, EventsRequest()) ??
          PagingResponse<Event>();
      events.value = initPagingList(_eventsRes);
    });
  }

  Future<void> listActivitiesMore(int page) async {
    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _eventsRes = await apiRepository.listProjectEvents(
              repository.project.value.id!, EventsRequest(page: page)) ??
          PagingResponse<Event>();
      if (page == 1) {
        events.value = initPagingList(_eventsRes);
      } else {
        events.addAll(initPagingList(_eventsRes));
      }
    });
  }

  Future<void> _scrollListener() async {
    scrollListener(scrollController, _eventsRes,
        (value) => listActivitiesMore(value), _page);
  }

  Future<void> onItemPressed(Event item) async {
    GitlabUtils.handleEvent(repository, item, false);
  }
}
