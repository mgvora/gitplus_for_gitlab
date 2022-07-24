import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/utils.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'project_members.dart';

class ProjectMembersScreen extends GetView<ProjectMembersController> {
  const ProjectMembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var l = controller.members.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Members".tr),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MembersDataSearch(
                      (s) {
                        controller.onSearchMembersTextChanged(s);
                      },
                      controller,
                    ));
              },
              tooltip: 'Search',
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                controller.onNavigateToAddMember();
              },
              tooltip: 'Add members',
              icon: const Icon(Icons.add)),
        ],
      ),
      body: _listWidget(controller.members, controller),
    );
  }
}

Widget _listWidget(List<Member> members, ProjectMembersController controller) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.list(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: controller.scrollController,
          child: ListView.builder(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (context, index) {
                var item = members[index];

                Widget state = Container();
                if (item.state == MemberStates.awaiting) {
                  state = Column(
                    children: [
                      const SizedBox(height: 3),
                      Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.orange.shade200,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Text('Awaiting',
                              style: TextStyle(fontSize: 12))),
                    ],
                  );
                }

                return Column(
                  children: [
                    ListTile(
                      leading: ListAvatar(avatarUrl: item.avatarUrl!),
                      title: Text(item.name!,
                          style: const TextStyle(
                              fontWeight: CommonConstants.fontWeightListTile)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.username!),
                          state,
                        ],
                      ),
                      trailing: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Get.theme.highlightColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Text(
                              GitlabUtils.getAccessLevelName(item.accessLevel!),
                              style: const TextStyle(fontSize: 12))),
                      onTap: () {
                        controller.onMemberSelected(item);
                      },
                    ),
                    const Divider(),
                  ],
                );
              }),
        ),
      ),
    ),
  );
}

class MembersDataSearch extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final ProjectMembersController controller;

  MembersDataSearch(this.onSearchTextChanged, this.controller)
      : super(
          searchFieldStyle: const TextStyle(color: Colors.grey),
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: searchLeadingIcon());
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearchTextChanged(query);
    return _listWidget(controller.foundMembers, controller);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _listWidget(controller.foundMembers, controller);
  }
}
