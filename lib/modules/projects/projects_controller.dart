import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class ProjectsController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  ProjectsController({
    required this.apiRepository,
    required this.repository,
  });

  var storage = Get.find<SPStorage>();
  var sstorage = Get.find<SecureStorage>();

  var selectedItem = AppDrawerItems.projects;
  var _currentTabIndex = 0;

  late StreamSubscription _projectupdateSubscription;
  late StreamSubscription _userChangedSubscription;

  late PagingResponse<Project> projectsResAll;
  late PagingResponse<Project> projectsResPersonal;
  late PagingResponse<Project> projectsResStarred;
  late PagingResponse<Project> projectsResPublic;

  final _findRequestAll = DelayedRequest();
  final _findRequestPersonal = DelayedRequest();
  final _findRequestStarred = DelayedRequest();
  final _findRequestPublic = DelayedRequest();

  var _searchQueryAll = "";
  var _searchQueryPersonal = "";
  var _searchQueryStarred = "";
  var _searchQueryPublic = "";

  late PagingResponse<Project> _allRes;
  late PagingResponse<Project> _personalRes;
  late PagingResponse<Project> _starredRes;
  late PagingResponse<Project> _publicRes;

  late PagingResponse<Project> _foundAllRes;
  late PagingResponse<Project> _foundPersonalRes;
  late PagingResponse<Project> _foundStarredRes;
  late PagingResponse<Project> _foundPublicRes;

  var _pagesAll = 0;
  var _pagesPersonal = 0;
  var _pagesStarred = 0;
  var _pagesPublic = 0;

  var _pagesSearchAll = 0;
  var _pagesSearchPersonal = 0;
  var _pagesSearchStarred = 0;
  var _pagesSearchPublic = 0;

  var all = <Project>[].obs;
  var personal = <Project>[].obs;
  var starred = <Project>[].obs;
  var public = <Project>[].obs;

  var foundAll = <Project>[].obs;
  var foundPersonal = <Project>[].obs;
  var foundStarred = <Project>[].obs;
  var foundPublic = <Project>[].obs;

  late ScrollController scrollControllerAll = ScrollController()
    ..addListener(_scrollListenerAll);
  late ScrollController scrollControllerPersonal = ScrollController()
    ..addListener(_scrollListenerPersonal);
  late ScrollController scrollControllerStarred = ScrollController()
    ..addListener(_scrollListenerStarred);
  late ScrollController scrollControllerPublic = ScrollController()
    ..addListener(_scrollListenerPublic);

  late ScrollController scrollControllerSearchAll = ScrollController()
    ..addListener(_scrollListenerSearchAll);
  late ScrollController scrollControllerSearchPersonal = ScrollController()
    ..addListener(_scrollListenerSearchPersonal);
  late ScrollController scrollControllerSearchStarred = ScrollController()
    ..addListener(_scrollListenerSearchStarred);
  late ScrollController scrollControllerSearchPublic = ScrollController()
    ..addListener(_scrollListenerSearchPublic);

  var stateAll = HttpState.loading.obs;
  var statePersonal = HttpState.loading.obs;
  var stateStarred = HttpState.loading.obs;
  var statePublic = HttpState.loading.obs;

  @override
  void onReady() async {
    super.onReady();
    listAll();

    _projectupdateSubscription = repository.projectsUpdate.listen((p0) {
      listAll();
    });

    _userChangedSubscription = sstorage.userChanged.listen((event) {
      if (_currentTabIndex == 0) {
        listAll();
      } else if (_currentTabIndex == 1) {
        listPersonal();
      } else if (_currentTabIndex == 2) {
        listStarred();
      }
    });
  }

  @override
  void onClose() {
    _projectupdateSubscription.cancel();
    _userChangedSubscription.cancel();

    _findRequestAll.dispose();
    _findRequestPersonal.dispose();
    _findRequestStarred.dispose();
    _findRequestPublic.dispose();

    scrollControllerAll.dispose();
    scrollControllerPersonal.dispose();
    scrollControllerStarred.dispose();
    scrollControllerPublic.dispose();
    scrollControllerSearchAll.dispose();
    scrollControllerSearchPersonal.dispose();
    scrollControllerSearchStarred.dispose();
    scrollControllerSearchPublic.dispose();

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

  /// :list

  Future<void> listAll() async {
    _pagesAll = 0;
    _pagesSearchAll = 0;
    await runWithErrorHandlingWithoutState(() async {
      stateAll.value = HttpState.loading;
      _allRes = await apiRepository.listProjects(ProjectsRequest(
              membership: true,
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      all.value = initPagingList(_allRes);
    }).then((value) {
      _handleHttpState(all, stateAll, value);
    });
  }

  Future<void> listAllMore(int page) async {
    _pagesAll = page;
    await runWithErrorHandlingWithoutState(() async {
      _allRes = await apiRepository.listProjects(ProjectsRequest(
              membership: true,
              page: page,
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      if (page == 1) {
        all.value = initPagingList(_allRes);
      } else {
        all.addAll(initPagingList(_allRes));
      }
    });
  }

  Future<void> listPersonal() async {
    _pagesPersonal = 0;
    _pagesSearchPersonal = 0;
    await runWithErrorHandlingWithoutState(() async {
      statePersonal.value = HttpState.loading;
      _personalRes = await apiRepository.listProjects(ProjectsRequest(
              visibility: "private",
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      personal.value = initPagingList(_personalRes);
    }).then((value) {
      _handleHttpState(personal, statePersonal, value);
    });
  }

  Future<void> listPersonalMore(int page) async {
    _pagesPersonal = page;
    await runWithErrorHandlingWithoutState(() async {
      _personalRes = await apiRepository.listProjects(ProjectsRequest(
              visibility: "private",
              page: page,
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      if (page == 1) {
        personal.value = initPagingList(_personalRes);
      } else {
        personal.addAll(initPagingList(_personalRes));
      }
    });
  }

  Future<void> listStarred() async {
    _pagesStarred = 0;
    _pagesSearchStarred = 0;
    await runWithErrorHandlingWithoutState(() async {
      stateStarred.value = HttpState.loading;
      _starredRes =
          await apiRepository.listProjects(ProjectsRequest(starred: true)) ??
              PagingResponse<Project>();
      starred.value = initPagingList(_starredRes);
    }).then((value) {
      _handleHttpState(starred, stateStarred, value);
    });
  }

  Future<void> listStarredMore(int page) async {
    _pagesStarred = page;
    await runWithErrorHandlingWithoutState(() async {
      _starredRes = await apiRepository
              .listProjects(ProjectsRequest(starred: true, page: page)) ??
          PagingResponse<Project>();
      if (page == 1) {
        starred.value = initPagingList(_starredRes);
      } else {
        starred.addAll(initPagingList(_starredRes));
      }
    });
  }

  Future<void> listPublic() async {
    _pagesPublic = 0;
    _pagesSearchPublic = 0;
    await runWithErrorHandlingWithoutState(() async {
      statePublic.value = HttpState.loading;
      _publicRes = await apiRepository.listProjects(
              ProjectsRequest(orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      public.value = initPagingList(_publicRes);
    }).then((value) {
      _handleHttpState(public, statePublic, value);
    });
  }

  Future<void> listPublicMore(int page) async {
    _pagesPublic = page;
    await runWithErrorHandlingWithoutState(() async {
      _publicRes = await apiRepository.listProjects(ProjectsRequest(
              page: page, orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      if (page == 1) {
        public.value = initPagingList(_publicRes);
      } else {
        public.addAll(initPagingList(_publicRes));
      }
    });
  }

  /// :listSearch

  Future<void> listSearchAll(int page, String query) async {
    _pagesSearchAll = page;
    _foundAllRes = await apiRepository.listProjects(
            ProjectsRequest(membership: true, search: query, page: page)) ??
        PagingResponse<Project>();
    if (page == 1) {
      foundAll.value = initPagingList(_foundAllRes);
    } else {
      foundAll.addAll(initPagingList(_foundAllRes));
    }
  }

  Future<void> listSearchPersonal(int page, String query) async {
    _pagesSearchPersonal = page;
    _foundPersonalRes = await apiRepository.listProjects(ProjectsRequest(
            visibility: "private", search: query, page: page)) ??
        PagingResponse<Project>();
    if (page == 1) {
      foundPersonal.value = initPagingList(_foundPersonalRes);
    } else {
      foundPersonal.addAll(initPagingList(_foundPersonalRes));
    }
  }

  Future<void> listSearchStarred(int page, String query) async {
    _pagesSearchStarred = page;
    _foundStarredRes = await apiRepository.listProjects(
            ProjectsRequest(starred: true, search: query, page: page)) ??
        PagingResponse<Project>();
    if (page == 1) {
      foundStarred.value = initPagingList(_foundStarredRes);
    } else {
      foundStarred.addAll(initPagingList(_foundStarredRes));
    }
  }

  Future<void> listSearchPublic(int page, String query) async {
    _pagesSearchPublic = page;
    _foundPublicRes = await apiRepository
            .listProjects(ProjectsRequest(search: query, page: page)) ??
        PagingResponse<Project>();
    if (page == 1) {
      foundPublic.value = initPagingList(_foundPublicRes);
    } else {
      foundPublic.addAll(initPagingList(_foundPublicRes));
    }
  }

  /// :searchTextChanged

  onSearchAllTextChanged(String s) {
    _searchQueryAll = s;
    _pagesSearchAll = 0;
    _findRequestAll.request(s, (str) async {
      _foundAllRes = await apiRepository
              .listProjects(ProjectsRequest(search: str, membership: true)) ??
          PagingResponse<Project>();
      foundAll.value = initPagingList(_foundAllRes);
    });
  }

  onSearchPersonalTextChanged(String s) {
    _searchQueryPersonal = s;
    _pagesSearchPersonal = 0;
    _findRequestPersonal.request(s, (str) async {
      _foundPersonalRes = await apiRepository.listProjects(
              ProjectsRequest(search: str, visibility: "private")) ??
          PagingResponse<Project>();
      foundPersonal.value = initPagingList(_foundPersonalRes);
    });
  }

  onSearchStarredTextChanged(String s) {
    _searchQueryStarred = s;
    _pagesSearchStarred = 0;
    _findRequestStarred.request(s, (str) async {
      _foundStarredRes = await apiRepository
              .listProjects(ProjectsRequest(search: str, starred: true)) ??
          PagingResponse<Project>();
      foundStarred.value = initPagingList(_foundStarredRes);
    });
  }

  onSearchPublicTextChanged(String s) {
    _searchQueryPublic = s;
    _pagesSearchPublic = 0;
    _findRequestPublic.request(s, (str) async {
      _foundPublicRes =
          await apiRepository.listProjects(ProjectsRequest(search: str)) ??
              PagingResponse<Project>();
      foundPublic.value = initPagingList(_foundPublicRes);
    });
  }

  void onProjectSelected(Project value) {
    repository.loadProjectRequired.value = false;
    repository.project.value = value;
    Get.toNamed(Routes.projectDetails);
  }

  void onTabChanged(int index) {
    _currentTabIndex = index;
    switch (index) {
      case 1:
        if (personal.isEmpty) {
          listPersonal();
        }
        break;
      case 2:
        if (starred.isEmpty) {
          listStarred();
        }
        break;
      case 3:
        if (public.isEmpty) {
          listPublic();
        }
        break;
    }
  }

  void _scrollListenerAll() {
    scrollListener(
        scrollControllerAll, _allRes, (value) => listAllMore(value), _pagesAll);
  }

  void _scrollListenerPersonal() {
    scrollListener(scrollControllerPersonal, _personalRes,
        (value) => listPersonalMore(value), _pagesPersonal);
  }

  void _scrollListenerStarred() {
    scrollListener(scrollControllerStarred, _starredRes,
        (value) => listStarredMore(value), _pagesStarred);
  }

  void _scrollListenerPublic() {
    scrollListener(scrollControllerPublic, _publicRes,
        (value) => listPublicMore(value), _pagesPublic);
  }

  void _scrollListenerSearchAll() {
    scrollListener(scrollControllerSearchAll, _foundAllRes,
        (value) => listSearchAll(value, _searchQueryAll), _pagesSearchAll);
  }

  void _scrollListenerSearchPersonal() {
    scrollListener(
        scrollControllerSearchPersonal,
        _foundPersonalRes,
        (value) => listSearchPersonal(value, _searchQueryPersonal),
        _pagesSearchPersonal);
  }

  void _scrollListenerSearchStarred() {
    scrollListener(
        scrollControllerSearchStarred,
        _foundStarredRes,
        (value) => listSearchStarred(value, _searchQueryStarred),
        _pagesSearchStarred);
  }

  void _scrollListenerSearchPublic() {
    scrollListener(
        scrollControllerSearchPublic,
        _foundPublicRes,
        (value) => listSearchPublic(value, _searchQueryPublic),
        _pagesSearchPublic);
  }
}
