import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/member_details/member_details.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class ProjectMembersController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  ProjectMembersController({
    required this.apiRepository,
    required this.repository,
  });

  late StreamSubscription _addMemberSubscription;

  var members = <Member>[].obs;
  var foundMembers = <Member>[].obs;
  var selectedMember = Member().obs;

  final _membersFind = DelayedRequest();

  late PagingResponse<Member> _membersRes;
  late PagingResponse<Member> _foundMembersRes;

  var _page = 0;

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  @override
  void onReady() async {
    super.onReady();
    list();

    _addMemberSubscription = repository.membersUpdate.listen((p0) {
      list();
    });
  }

  @override
  void onClose() {
    _addMemberSubscription.cancel();
    _membersFind.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> list() async {
    await runWithErrorHandling(() async {
      _membersRes = await apiRepository.listProjectMembers(
              repository.project.value.id!, MembersRequest()) ??
          PagingResponse<Member>();
      members.value = initPagingList(_membersRes);
    }).then((value) {
      if (value == 401) {
        state.value = HttpState.tokenExpired;
        return;
      }
      if (value > 0) return;
      if (members.isEmpty) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          state.value = HttpState.empty;
        });
      }
    });
  }

  Future<void> listMore(int page) async {
    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _membersRes = await apiRepository.listProjectMembers(
              repository.project.value.id!, MembersRequest(page: page)) ??
          PagingResponse<Member>();
      if (page == 1) {
        members.value = initPagingList(_membersRes);
      } else {
        members.addAll(initPagingList(_membersRes));
      }
    });
  }

  void onMemberSelected(Member item) {
    selectedMember.value = item;
    Get.toNamed(
      Routes.memberDetails,
      arguments:
          MemberDetailsScreenArgs(member: item, onRemove: onRemoveMember),
    );
  }

  Future<void> onRemoveMember() async {
    EasyLoading.show();
    await runWithErrorHandlingWithoutState(() async {
      await apiRepository.removeProjectMember(
          repository.project.value.id!, selectedMember.value.id!);
      list();
    }).then((value) => handleHttpActionWithoutState(value));
    EasyLoading.dismiss();
  }

  void onSearchMembersTextChanged(String s) {
    _membersFind.request(s, (str) async {
      await runWithErrorHandlingWithoutState(() async {
        _foundMembersRes = await apiRepository.listProjectMembers(
                repository.project.value.id!, MembersRequest(query: str)) ??
            PagingResponse<Member>();
        foundMembers.value = initPagingList(_foundMembersRes);
      });
    });
  }

  void _scrollListener() {
    scrollListener(
        scrollController, _membersRes, (value) => listMore(value), _page);
  }

  void onNavigateToAddMember() {
    Get.toNamed(Routes.addMembers);
  }
}
