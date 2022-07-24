import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/member_details/member_details.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class GroupsController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  GroupsController({
    required this.apiRepository,
    required this.repository,
  });

  var storage = Get.find<SPStorage>();

  var selectedItem = AppDrawerItems.groups;

  var tabControlIndex = 0.obs;

  var groups = <Group>[].obs;
  var foundGroups = <Group>[].obs;
  var projects = <Project>[].obs;
  var foundProjects = <Project>[].obs;
  var members = <Member>[].obs;
  var foundMembers = <Member>[].obs;
  var selectedMember = Member().obs;

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final pathController = TextEditingController();
  final descriptionController = TextEditingController();

  late StreamSubscription _membersSubsription;
  late StreamSubscription _projectsSubscription;

  late PagingResponse<Group> _groupsRes;
  late PagingResponse<Project> _projectsRes;
  late PagingResponse<Member> _membersRes;

  var _groupsPage = 0;
  var _projectsPage = 0;
  var _membersPage = 0;

  final _groupFind = DelayedRequest();
  final _projectsFind = DelayedRequest();
  final _membersFind = DelayedRequest();

  late ScrollController scrollControllerGroups = ScrollController()
    ..addListener(_scrollListenerGroups);
  late ScrollController scrollControllerSearchGroups = ScrollController()
    ..addListener(_scrollListenerSearchGroups);
  late ScrollController scrollControllerProjects = ScrollController()
    ..addListener(_scrollListenerProjects);
  late ScrollController scrollControllerMembers = ScrollController()
    ..addListener(_scrollListenerMembers);

  var groupsState = HttpState.loading.obs;
  var projectsState = HttpState.loading.obs;
  var membersState = HttpState.loading.obs;

  @override
  void onReady() {
    super.onReady();
    listGroups();

    _membersSubsription = repository.membersUpdate.listen((p0) {
      listMembers();
    });

    _projectsSubscription = repository.projectsUpdate.listen((p0) {
      listProjects();
    });
  }

  @override
  void onClose() {
    _membersSubsription.cancel();
    _projectsSubscription.cancel();
    _groupFind.dispose();
    _projectsFind.dispose();
    _membersFind.dispose();

    scrollControllerGroups.dispose();
    scrollControllerSearchGroups.dispose();
    scrollControllerProjects.dispose();
    scrollControllerMembers.dispose();

    nameController.dispose();
    pathController.dispose();
    descriptionController.dispose();

    super.onClose();
  }

  Future<void> listGroups() async {
    await runWithErrorHandlingWithoutState(() async {
      groupsState.value = HttpState.loading;
      _groupsRes = await apiRepository.listGroups(GroupsRequest()) ??
          PagingResponse<Group>();
      groups.value = initPagingList(_groupsRes);
    }).then((value) {
      if (value == 401) {
        groupsState.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) {
        groupsState.value = HttpState.error;
        return;
      }
      if (groups.isEmpty) {
        groupsState.value = HttpState.empty;
      } else {
        groupsState.value = HttpState.ok;
      }
    });
  }

  Future<void> listGroupsMore(int page) async {
    _groupsPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _groupsRes = await apiRepository.listGroups(GroupsRequest(page: page)) ??
          PagingResponse<Group>();
      if (page == 1) {
        groups.value = initPagingList(_groupsRes);
      } else {
        groups.addAll(initPagingList(_groupsRes));
      }
    });
  }

  Future<void> listProjects() async {
    await runWithErrorHandlingWithoutState(() async {
      projectsState.value = HttpState.loading;
      _projectsRes = await apiRepository.listGroupProjects(
              repository.group.value.id!,
              GroupProjectsRequest(
                  orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      projects.value = initPagingList(_projectsRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) {
        projectsState.value = HttpState.error;
        return;
      }
      if (projects.isEmpty) {
        projectsState.value = HttpState.empty;
      } else {
        projectsState.value = HttpState.ok;
      }
    });
  }

  Future<void> listProjectsMore(int page) async {
    _projectsPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _projectsRes = await apiRepository.listGroupProjects(
              repository.group.value.id!,
              GroupProjectsRequest(
                  page: page, orderBy: ProjectRequestOrderBy.lastActivityAt)) ??
          PagingResponse<Project>();
      if (page == 1) {
        projects.value = initPagingList(_projectsRes);
      } else {
        projects.addAll(initPagingList(_projectsRes));
      }
    });
  }

  Future<void> listMembers() async {
    await runWithErrorHandlingWithoutState(() async {
      membersState.value = HttpState.loading;
      _membersRes = await apiRepository.listGroupMembers(
              repository.group.value.id!, MembersRequest()) ??
          PagingResponse<Member>();
      members.value = initPagingList(_membersRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) {
        membersState.value = HttpState.error;
        return;
      }
      if (members.isEmpty) {
        membersState.value = HttpState.empty;
      } else {
        membersState.value = HttpState.ok;
      }
    });
  }

  Future<void> listMembersMore(int page) async {
    _membersPage = page;
    await runWithErrorHandlingWithoutState(() async {
      _membersRes = await apiRepository.listGroupMembers(
              repository.group.value.id!, MembersRequest(page: page)) ??
          PagingResponse<Member>();
      if (page == 1) {
        members.value = initPagingList(_membersRes);
      } else {
        members.addAll(initPagingList(_membersRes));
      }
    });
  }

  void onGroupSelected(Group item) {
    repository.group.value = item;
    Get.toNamed(Routes.groups + Routes.groupDetails, arguments: this);
  }

  void onAddGroupOpenScreen() {
    Get.toNamed(Routes.groups + Routes.addGroup, arguments: this);
  }

  Future<void> onAddGroup() async {
    EasyLoading.show();
    await runWithErrorHandling(() async {
      await apiRepository.addGroup(AddGroupRequest(
        name: nameController.value.text,
        path: pathController.value.text,
      ));
      listGroups();
      Get.back();
    });
    EasyLoading.dismiss();
  }

  void onTabChanged(int index) {
    tabControlIndex.value = index;
  }

  void onAddMemberOpenScreen() {
    repository.membersFor = MembersFor.group;
    Get.toNamed(Routes.addMembers);
  }

  void onProjectSelected(Project item) {
    repository.project.value = item;
    Get.toNamed(Routes.projectDetails);
  }

  void groupDetailsDisposed() {
    projects.value = [];
    members.value = [];
  }

  void onMemberSelected(Member item) {
    selectedMember.value = item;
    Get.toNamed(Routes.memberDetails,
        arguments:
            MemberDetailsScreenArgs(member: item, onRemove: onRemoveMember));
  }

  Future<void> onRemoveMember() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.removeGroupMember(
          repository.group.value.id!, selectedMember.value.id!);
      listMembers();
    }).then((value) => handleHttpActionState(value));
    EasyLoading.dismiss();
  }

  Future<void> onSearchGroupsTextChanged(String s) async {
    _groupFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        var res = await apiRepository.listGroups(GroupsRequest(search: str)) ??
            PagingResponse<Group>();
        foundGroups.value = initPagingList(res);
      });
    });
  }

  onSearchProjectsTextChanged(String s) {
    _projectsFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        var res = await apiRepository.listGroupProjects(
                repository.group.value.id!,
                GroupProjectsRequest(search: str)) ??
            PagingResponse<Project>();
        foundProjects.value = initPagingList(res);
      });
    });
  }

  onSearchMembersTextChanged(String s) {
    _membersFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        var res = await apiRepository.listGroupMembers(
                repository.group.value.id!, MembersRequest(query: str)) ??
            PagingResponse<Member>();
        foundMembers.value = initPagingList(res);
      });
    });
  }

  void _scrollListenerGroups() {
    scrollListener(scrollControllerGroups, _groupsRes,
        (value) => listGroupsMore(value), _groupsPage);
  }

  void _scrollListenerSearchGroups() {
    scrollListener(scrollControllerSearchGroups, _groupsRes,
        (value) => listGroupsMore(value), _groupsPage);
  }

  void _scrollListenerProjects() {
    scrollListener(scrollControllerProjects, _projectsRes,
        (value) => listProjectsMore(value), _projectsPage);
  }

  void _scrollListenerMembers() {
    scrollListener(scrollControllerMembers, _membersRes,
        (value) => listMembersMore(value), _membersPage);
  }
}
