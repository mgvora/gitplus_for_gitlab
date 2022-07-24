import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class BranchesController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  BranchesController({
    required this.apiRepository,
    required this.repository,
  });

  var tabControlIndex = 0.obs;

  var branches = <Branch>[].obs;
  var tags = <Tag>[].obs;

  var foundBranches = <Branch>[].obs;
  var foundTags = <Tag>[].obs;

  var _pageBranches = 0;
  var _pageTags = 0;

  late PagingResponse<Branch> _branchesRes;
  late PagingResponse<Tag> _tagsRes;

  final _branchesFind = DelayedRequest();
  final _tagsFind = DelayedRequest();

  late ScrollController scrollControllerBranches = ScrollController()
    ..addListener(_scrollListenerBranches);
  late ScrollController scrollControllerTags = ScrollController()
    ..addListener(_scrollListenerTags);

  var stateBranch = HttpState.loading.obs;
  var stateTags = HttpState.loading.obs;

  @override
  void onReady() async {
    super.onReady();

    list();
  }

  @override
  void onClose() {
    scrollControllerBranches.dispose();
    scrollControllerTags.dispose();
    _branchesFind.dispose();
    _tagsFind.dispose();
    super.onClose();
  }

  Future<void> list() async {
    await runWithErrorHandlingWithoutState(() async {
      stateBranch.value = HttpState.loading;
      _branchesRes = await apiRepository.listBranches(
              repository.project.value.id!, BranchesRequest()) ??
          PagingResponse<Branch>();
      branches.value = initPagingList(_branchesRes);
    }).then((value) {
      if (value > 0) {
        if (value == 401) {
          state.value = HttpState.tokenExpired;
          return;
        }
        stateBranch.value = HttpState.error;
        return;
      }
      if (branches.isEmpty) {
        stateBranch.value = HttpState.empty;
      } else {
        stateBranch.value = HttpState.ok;
      }
    });
  }

  Future<void> listMore(int page) async {
    _pageBranches = page;
    await runWithErrorHandlingWithoutState(() async {
      _branchesRes = await apiRepository.listBranches(
              repository.project.value.id!, BranchesRequest(page: page)) ??
          PagingResponse<Branch>();
      if (page == 1) {
        branches.value = initPagingList(_branchesRes);
      } else {
        branches.addAll(initPagingList(_branchesRes));
      }
    });
  }

  Future<void> listTags() async {
    await runWithErrorHandlingWithoutState(() async {
      stateTags.value = HttpState.loading;
      _tagsRes = await apiRepository.listTags(
              repository.project.value.id!, TagsRequest()) ??
          PagingResponse<Tag>();
      tags.value = initPagingList(_tagsRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) {
        stateTags.value = HttpState.error;
        return;
      }
      if (tags.isEmpty) {
        stateTags.value = HttpState.empty;
      } else {
        stateTags.value = HttpState.ok;
      }
    });
  }

  Future<void> listTagsMore(int page) async {
    _pageTags = page;
    await runWithErrorHandlingWithoutState(() async {
      _tagsRes = await apiRepository.listTags(
              repository.project.value.id!, TagsRequest(page: page)) ??
          PagingResponse<Tag>();
      if (page == 1) {
        tags.value = initPagingList(_tagsRes);
      } else {
        tags.addAll(initPagingList(_tagsRes));
      }
    });
  }

  void onSearchBranchesTextChanged(String s) {
    _branchesFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        var res = await apiRepository.listBranches(
                repository.project.value.id!, BranchesRequest(search: str)) ??
            PagingResponse<Branch>();
        foundBranches.value = initPagingList(res);
      });
    });
  }

  void onSearchTagsTextChanged(String s) {
    _tagsFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        var res = await apiRepository.listTags(
                repository.project.value.id!, TagsRequest(search: str)) ??
            PagingResponse<Tag>();
        foundTags.value = initPagingList(res);
      });
    });
  }

  void _scrollListenerBranches() {
    scrollListener(scrollControllerBranches, _branchesRes,
        (value) => listMore(value), _pageBranches);
  }

  void _scrollListenerTags() {
    scrollListener(scrollControllerTags, _tagsRes,
        (value) => listTagsMore(value), _pageTags);
  }

  void onTabChanged(int index) {
    tabControlIndex.value = index;
  }

  void groupDetailsDisposed() {
    branches.value = [];
    tags.value = [];
  }
}
