import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/api/utils.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/home/home.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  HomeController({
    required this.apiRepository,
    required this.repository,
  });

  var storage = Get.find<SPStorage>();
  var sstorage = Get.find<SecureStorage>();

  var selectedItem = AppDrawerItems.dashboard;

  var currentTab = MainTabs.events.obs;

  var projectsTab = const ProjectsTab();
  var activityTab = const ActivityTab();
  var issuesTab = const IssuesTab();
  var mergeRequestsTab = const MergeRequestsTab();

  late ScrollController projectsScrollController = ScrollController()
    ..addListener(_projectsScrollListener);
  late ScrollController eventsScrollController = ScrollController()
    ..addListener(_eventsScrollListener);
  late ScrollController issuesScrollController = ScrollController()
    ..addListener(_issuesScrollListener);
  late ScrollController mrScrollController = ScrollController()
    ..addListener(_mrScrollListener);

  late StreamSubscription _projectupdateSubscription;
  late StreamSubscription _userChangedSubscription;

  late PagingResponse<Project> _projectsRes;
  late PagingResponse<Event> _eventsRes;
  late PagingResponse<Issue> _issuesRes;
  late PagingResponse<MergeRequest> _mergeRequestsRes;

  var projects = <Project>[].obs;
  var events = <Event>[].obs;
  var issues = <Issue>[].obs;
  var mergeRequests = <MergeRequest>[].obs;

  var mergeRequestsFilterScope = MergeRequestScope.all.obs;
  var mergeRequestsFilterState = ''.obs;
  var issuesFilterScope = IssuesScope.all.obs;
  var issuesFilterState = ''.obs;

  var _projectsPage = 0;
  var _eventsPage = 0;
  var _issuesPage = 0;
  var _mergeRequestsPage = 0;

  var projectsState = HttpState.loading.obs;
  var eventsState = HttpState.loading.obs;
  var issuesState = HttpState.loading.obs;
  var mrState = HttpState.loading.obs;

  var title = "".obs;

  var ready = false;

  @override
  void onReady() {
    ready = true;
    var sstorage = Get.find<SecureStorage>();
    repository.account.value = sstorage.getDefaultAccount();

    switchTab(storage.getHomeDefaultTab());

    _projectupdateSubscription = repository.projectsUpdate.listen((p0) {
      listProjects();
    });
    _userChangedSubscription = sstorage.userChanged.listen((event) {
      if (currentTab.value == MainTabs.projects) {
        listProjects();
      } else if (currentTab.value == MainTabs.events) {
        listEvents();
      } else if (currentTab.value == MainTabs.issues) {
        listIssues();
      } else {
        listMergeRequests();
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    ready = false;
    projectsScrollController.dispose();
    eventsScrollController.dispose();
    issuesScrollController.dispose();
    mrScrollController.dispose();
    _projectupdateSubscription.cancel();
    _userChangedSubscription.cancel();

    super.onClose();
  }

  void switchTab(int index) {
    switch (index) {
      case 0:
        listProjects();
        break;
      case 1:
        listEvents();
        break;
      case 2:
        listIssues();
        break;
      case 3:
        listMergeRequests();
        break;
      default:
        listProjects();
    }

    var tab = _getCurrentTab(index);
    currentTab.value = tab;

    var storage = Get.find<SPStorage>();
    storage.setHomeDefaultTab(index);
  }

  int getCurrentIndex(MainTabs tab) {
    return tab.index;
  }

  MainTabs _getCurrentTab(int index) {
    return MainTabs.values[index];
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

  Future<void> listProjects() async {
    title.value = "Your projects";
    _projectsPage = 0;
    await runWithErrorHandlingWithoutState(() async {
      projectsState.value = HttpState.loading;
      _projectsRes = await apiRepository.listProjects(ProjectsRequest(
              membership: true,
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      projects.value = initPagingList(_projectsRes);
    }).then((value) {
      _handleHttpState(projects, projectsState, value);
    });
  }

  Future<void> listProjectsMore(int page) async {
    _projectsPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _projectsRes = await apiRepository.listProjects(ProjectsRequest(
              membership: true,
              page: page,
              orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      if (page == 1) {
        projects.value = initPagingList(_projectsRes);
      } else {
        projects.addAll(initPagingList(_projectsRes));
      }
    });
  }

  Future<void> listEvents() async {
    title.value = "Events";
    _eventsPage = 0;
    await runWithErrorHandlingWithoutState(() async {
      eventsState.value = HttpState.loading;
      _eventsRes = await apiRepository.listEvents(EventsRequest()) ??
          PagingResponse<Event>();
      events.value = initPagingList(_eventsRes);
    }).then((value) {
      _handleHttpState(events, eventsState, value);
    });
  }

  Future<void> listEventsMore(int page) async {
    _eventsPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _eventsRes = await apiRepository.listEvents(EventsRequest(page: page)) ??
          PagingResponse<Event>();
      if (page == 1) {
        events.value = initPagingList(_eventsRes);
      } else {
        events.addAll(initPagingList(_eventsRes));
      }
    });
  }

  Future<void> listIssues() async {
    title.value = "Issues";
    _issuesPage = 0;
    String? scope;
    if (issuesFilterScope.value != IssuesScope.all) {
      scope = issuesFilterScope.value;
    }

    String? istate;
    if (issuesFilterState.isNotEmpty) {
      istate = issuesFilterState.value;
    }
    await runWithErrorHandlingWithoutState(() async {
      issuesState.value = HttpState.loading;
      _issuesRes = await apiRepository
              .listIssues(IssuesRequest(state: istate, scope: scope)) ??
          PagingResponse<Issue>();
      issues.value = initPagingList(_issuesRes);
    }).then((value) {
      _handleHttpState(issues, issuesState, value);
    });
  }

  Future<void> listIssuesMore(int page) async {
    String? scope;
    if (issuesFilterScope.value != IssuesScope.all) {
      scope = issuesFilterScope.value;
    }

    String? state;
    if (issuesFilterState.isNotEmpty) {
      state = issuesFilterState.value;
    }

    _issuesPage = page;

    await runWithErrorHandlingWithoutState(() async {
      _issuesRes = await apiRepository.listIssues(
              IssuesRequest(page: page, state: state, scope: scope)) ??
          PagingResponse<Issue>();
      if (page == 1) {
        issues.value = initPagingList(_issuesRes);
      } else {
        issues.addAll(initPagingList(_issuesRes));
      }
    });
  }

  Future<void> listMergeRequests() async {
    title.value = "Merge Requests";
    _mergeRequestsPage = 0;
    String? scope;
    if (mergeRequestsFilterScope.value != MergeRequestScope.all) {
      scope = mergeRequestsFilterScope.value;
    }

    String? mstate;
    if (mergeRequestsFilterState.isNotEmpty) {
      mstate = mergeRequestsFilterState.value;
    }

    await runWithErrorHandlingWithoutState(() async {
      mrState.value = HttpState.loading;
      _mergeRequestsRes = await apiRepository.listMergeRequests(
              MergeRequestRequest(state: mstate, scope: scope)) ??
          PagingResponse<MergeRequest>();
      mergeRequests.value = initPagingList(_mergeRequestsRes);
    }).then((value) {
      _handleHttpState(mergeRequests, mrState, value);
    });
  }

  Future<void> listMergeRequestsMore(int page) async {
    String? scope;
    if (mergeRequestsFilterScope.value != MergeRequestScope.all) {
      scope = mergeRequestsFilterScope.value;
    }

    String? state;
    if (mergeRequestsFilterState.isNotEmpty) {
      state = mergeRequestsFilterState.value;
    }

    _mergeRequestsPage = page;

    await runWithErrorHandlingWithoutState(() async {
      _mergeRequestsRes = await apiRepository.listMergeRequests(
              MergeRequestRequest(page: page, state: state, scope: scope)) ??
          PagingResponse<MergeRequest>();
      if (page == 1) {
        mergeRequests.value = initPagingList(_mergeRequestsRes);
      } else {
        mergeRequests.addAll(initPagingList(_mergeRequestsRes));
      }
    });
  }

  Future<void> _projectsScrollListener() async {
    scrollListener(projectsScrollController, _projectsRes,
        (value) => listProjectsMore(value), _projectsPage);
  }

  Future<void> _eventsScrollListener() async {
    scrollListener(eventsScrollController, _eventsRes,
        (value) => listEventsMore(value), _eventsPage);
  }

  Future<void> _issuesScrollListener() async {
    scrollListener(issuesScrollController, _issuesRes,
        (value) => listIssuesMore(value), _issuesPage);
  }

  Future<void> _mrScrollListener() async {
    scrollListener(mrScrollController, _mergeRequestsRes,
        (value) => listMergeRequestsMore(value), _mergeRequestsPage);
  }

  void onNavToIssueDetails(Issue item) {
    repository.loadProjectRequired.value = true;
    repository.project.value = Project();
    repository.projectId = item.projectId!;
    repository.issue.value = item;
    Get.toNamed(Routes.issue);
  }

  void onNavToMergeRequestDetails(MergeRequest item) {
    repository.loadProjectRequired.value = true;
    repository.project.value = Project();
    repository.projectId = item.projectId!;
    repository.mergeRequest.value = item;
    Get.toNamed(Routes.mergeRequest);
  }

  void onMergeRequestScopeChanged(String value) {
    _mergeRequestsPage = 0;
    mergeRequestsFilterScope.value = value;
    listMergeRequests();
    storage.setMergeRequestFilterScope(value);
  }

  void onMergeRequestStateChanged(String value) {
    _mergeRequestsPage = 0;
    mergeRequestsFilterState.value = value;
    listMergeRequests();
    storage.setMergeRequestFilterState(value);
  }

  void onIssuesStateChanged(String value) {
    _issuesPage = 0;
    issuesFilterState.value = value;
    listIssues();
    storage.setIssuesFilterState(value);
  }

  void onIssuesScopeChanged(String value) {
    _issuesPage = 0;
    issuesFilterScope.value = value;
    listIssues();
    storage.setIssuesFilterScope(value);
  }

  onEventPressed(Event item) {
    repository.loadProjectRequired.value = true;
    GitlabUtils.handleEvent(repository, item, true);
  }

  void onProjectSelected(Project value) {
    repository.loadProjectRequired.value = false;
    repository.project.value = value;
    Get.toNamed(Routes.projectDetails);
  }
}
