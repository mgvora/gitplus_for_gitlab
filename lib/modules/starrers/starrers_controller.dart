import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class StarrersController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  StarrersController({
    required this.apiRepository,
    required this.repository,
  });

  var starrers = <Starrer>[].obs;
  var foundStarrers = <Starrer>[].obs;

  late PagingResponse<Starrer> _starrersRes;

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  var _pages = 0;

  @override
  void onReady() async {
    super.onReady();
    list();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    super.onClose();
  }

  Future<void> list() async {
    await runWithErrorHandling(() async {
      _starrersRes = await apiRepository.listProjectStarrers(
              repository.project.value.id!, StarrersRequest()) ??
          PagingResponse<Starrer>();
      starrers.value = initPagingList(_starrersRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) return;
      if (starrers.isEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          state.value = HttpState.empty;
        });
      }
    });
  }

  Future<void> listMore(int page) async {
    _pages = page;
    await runWithErrorHandlingWithoutState(() async {
      _starrersRes = await apiRepository.listProjectStarrers(
              repository.project.value.id!, StarrersRequest(page: page)) ??
          PagingResponse<Starrer>();
      if (page == 1) {
        starrers.value = initPagingList(_starrersRes);
      } else {
        starrers.addAll(initPagingList(_starrersRes));
      }
    });
  }

  void _scrollListener() {
    scrollListener(
        scrollController, _starrersRes, (value) => listMore(value), _pages);
  }
}
