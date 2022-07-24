import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

import 'add_members_screen.dart';

class AddMembersController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  AddMembersController({
    required this.apiRepository,
    required this.repository,
  });

  var users = <User>[].obs;
  var addedUsers = <User>[].obs;
  var accessLevels = <AccessLevelItem>[].obs;
  var selectedAccessLevel = AccessLevelItem(name: "", value: 0).obs;

  late PagingResponse<User> _usersRes;
  final _usersFind = DelayedRequest();
  var _search = "";

  var _page = 0;

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  @override
  void onInit() {
    super.onInit();
    accessLevels.value = [
      // AccessLevelItem(name: 'No access', value: MemberAccessLevel.noAccess),
      // AccessLevelItem(
      //     name: 'Minimal access', value: MemberAccessLevel.minimalAccess),
      AccessLevelItem(name: 'Guest', value: MemberAccessLevel.guest),
      AccessLevelItem(name: 'Reporter', value: MemberAccessLevel.reporter),
      AccessLevelItem(name: 'Developer', value: MemberAccessLevel.developer),
      AccessLevelItem(name: 'Maintener', value: MemberAccessLevel.maintaner),
      // AccessLevelItem(name: 'Owner', value: MemberAccessLevel.owner),
    ];
    selectedAccessLevel.value = accessLevels[2];
  }

  @override
  void onClose() {
    scrollController.dispose();
    _usersFind.dispose();
    super.onClose();
  }

  Future<void> onSearchTextChanged(String s) async {
    _usersFind.request(s, (str) async {
      _search = str;
      await runWithErrorHandlingWithoutState(() async {
        _usersRes =
            await apiRepository.listUsers(FindUsersRequest(search: str)) ??
                PagingResponse<User>();
        users.value = initPagingList(_usersRes);
      }).then((value) {
        if (value == 401) {
          state.value = HttpState.tokenExpired;
          return;
        }
        if (value > 0) return;
        if (users.isEmpty) {
          state.value = HttpState.empty;
        } else {
          state.value = HttpState.ok;
        }
      });
    });
  }

  Future<void> listUsersMore(int page) async {
    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _usersRes = await apiRepository
              .listUsers(FindUsersRequest(page: page, search: _search)) ??
          PagingResponse<User>();
      if (page == 1) {
        users.value = initPagingList(_usersRes);
      } else {
        users.addAll(initPagingList(_usersRes));
      }
    });
  }

  void onItemAdd(User item) {
    var exist = addedUsers.any((p0) => p0.id == item.id);
    if (exist) {
      return;
    }
    addedUsers.add(item);
  }

  void onItemRemove(User item) {
    addedUsers.removeWhere((element) => element.id == item.id);
  }

  Future<void> onSubmit() async {
    var idsList = <String>[];

    for (var item in addedUsers) {
      idsList.add(item.id!.toString());
    }

    var ids = idsList.join(',');

    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      if (repository.membersFor == MembersFor.project) {
        await apiRepository.addProjectMember(
            repository.project.value.id!,
            AddMemberRequest(
              userId: ids,
              accessLevel: selectedAccessLevel.value.value,
            ));
      } else {
        await apiRepository.addGroupMember(
            repository.group.value.id!,
            AddMemberRequest(
              userId: ids,
              accessLevel: selectedAccessLevel.value.value,
            ));
      }

      repository.membersUpdate.value++;
      Get.back();
    }).then((value) => handleHttpActionState(value));

    EasyLoading.dismiss();
  }

  void onAccessLevelChanged(AccessLevelItem? value) {
    if (value == null) {
      return;
    }
    selectedAccessLevel.value = value;
  }

  void _scrollListener() {
    scrollListener(
        scrollController, _usersRes, (value) => listUsersMore(value), _page);
  }
}
