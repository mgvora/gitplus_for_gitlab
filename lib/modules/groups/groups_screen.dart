import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'groups_controller.dart';

class GroupsScreen extends GetView<GroupsController> {
  const GroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).canPop(),
      child: Obx(() => _buildWidget(context)),
    );
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: CrossFade<String>(
          initialData: '',
          data: 'Groups',
          builder: (value) => Text(value),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: GroupsDataSearch(controller));
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
          IconButton(
            onPressed: () {
              controller.onAddGroupOpenScreen();
            },
            icon: const Icon(Icons.add),
            tooltip: 'New group',
          ),
        ],
      ),
      drawer: AppDrawer(
        selected: controller.selectedItem,
        account: controller.repository.account.value,
        repository: controller.repository,
      ),
      body: _listWidget(controller.groups, context, controller,
          controller.scrollControllerGroups),
    );
  }
}

class GroupsDataSearch extends SearchDelegate<String> {
  late final GroupsController controller;

  GroupsDataSearch(this.controller)
      : super(
          searchFieldStyle: const TextStyle(color: Colors.grey),
          searchFieldLabel: 'Search',
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
    controller.onSearchGroupsTextChanged(query);
    return _listWidget(controller.foundGroups, context, controller,
        controller.scrollControllerSearchGroups);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.onSearchGroupsTextChanged(query);
    return _listWidget(controller.foundGroups, context, controller,
        controller.scrollControllerSearchGroups);
  }
}

Widget _listWidget(List<Group> groups, context, GroupsController controller,
    ScrollController scrollControllerGroups) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.listGroups(),
      child: HttpFutureBuilder(
        state: controller.groupsState.value,
        child: Scrollbar(
          controller: scrollControllerGroups,
          child: ListView.builder(
              controller: scrollControllerGroups,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                var item = groups[index];

                var name = "";
                if (item.name != null && item.name!.length > 1) {
                  name = item.name!.toUpperCase().substring(0, 2);
                } else {
                  name = item.name!.toUpperCase().substring(0, 1);
                }

                return Column(
                  children: [
                    ListTile(
                      // contentPadding:
                      //     const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      leading: ListVisibilityTextAvatar(
                          text: name, visibility: item.visibility!),
                      title: Text(item.name ?? '',
                          style: const TextStyle(
                              fontWeight: CommonConstants.fontWeightListTile)),
                      subtitle: item.fullName != item.name
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (item.fullName != item.name)
                                  Text(item.fullName!),
                              ],
                            )
                          : null,
                      onTap: () {
                        controller.onGroupSelected(item);
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

// Widget _iconLabel(IconData icon, String text) {
//   return Row(
//     children: [
//       Icon(icon, size: 16),
//       const SizedBox(width: 2),
//       Text(text, style: const TextStyle(fontSize: 12)),
//     ],
//   );
// }
