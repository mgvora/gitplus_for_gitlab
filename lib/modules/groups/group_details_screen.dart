import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/utils.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'groups_controller.dart';

class GroupsDetailsScreen extends StatefulWidget {
  const GroupsDetailsScreen({Key? key}) : super(key: key);

  @override
  _GroupsDetailsScreenState createState() => _GroupsDetailsScreenState();
}

class _GroupsDetailsScreenState extends State<GroupsDetailsScreen>
    with SingleTickerProviderStateMixin {
  final GroupsController _controller = Get.arguments;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = _controller.tabControlIndex.value;
    _tabController.addListener(() => _tabChangedListener(_tabController.index));

    if (_tabController.index == 0) {
      _controller.listProjects();
    } else {
      _controller.listMembers();
    }
  }

  void _tabChangedListener(int index) {
    _controller.onTabChanged(_tabController.index);
    if (_tabController.index == 0) {
      if (_controller.projects.isNotEmpty) {
        return;
      }
      _controller.listProjects();
    } else {
      if (_controller.members.isNotEmpty) {
        return;
      }
      _controller.listMembers();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(() => _tabChangedListener);
    _tabController.dispose();
    _controller.groupDetailsDisposed();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget());
  }

  Widget _buildWidget() {
    List<Widget> addAction;
    if (_controller.tabControlIndex.value == 0) {
      addAction = [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: DataSearchProjects(
                    (s) {
                      _controller.onSearchProjectsTextChanged(s);
                    },
                    _controller,
                  ));
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search project'),
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.createProject);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add project'),
      ];
    } else {
      addAction = [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: DataSearchMembers(
                    (s) {
                      _controller.onSearchMembersTextChanged(s);
                    },
                    _controller,
                  ));
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search member'),
        IconButton(
            onPressed: () {
              _controller.onAddMemberOpenScreen();
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add members'),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_controller.repository.group.value.name!),
        actions: addAction,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: const [
            Tab(text: "Projects"),
            Tab(text: "Members"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _projectsWidget(_controller.projects, _controller),
          _membersWidget(_controller.members, _controller),
        ],
      ),
    );
  }
}

class DataSearchProjects extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final GroupsController controller;

  DataSearchProjects(this.onSearchTextChanged, this.controller)
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
    return _projectsWidget(controller.foundProjects, controller);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _projectsWidget(controller.foundProjects, controller);
  }
}

class DataSearchMembers extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final GroupsController controller;

  DataSearchMembers(this.onSearchTextChanged, this.controller)
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
    return _membersWidget(controller.foundMembers, controller);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _membersWidget(controller.foundMembers, controller);
  }
}

Widget _projectsWidget(List<Project> projects, GroupsController controller) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.listProjects(),
      child: HttpFutureBuilder(
        state: controller.projectsState.value,
        child: ListView.builder(
            controller: controller.scrollControllerProjects,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              var item = projects[index];

              Widget avatar;
              if (item.avatarUrl != null && item.avatarUrl!.isNotEmpty) {
                avatar = ListAvatar(avatarUrl: item.avatarUrl!);
              } else {
                avatar = CircleAvatar(
                    child: Text(item.name!.toUpperCase().substring(0, 2)));
              }

              return Column(
                children: [
                  ListTile(
                    contentPadding: CommonConstants.contentPaddingLitTileLarge,
                    leading: avatar,
                    title: Text(item.name ?? '', style: const TextStyle()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.description != null &&
                            item.description!.isNotEmpty)
                          Text(item.description!),
                        const SizedBox(height: 5),
                        Text(timeago.format(item.lastActivityAt!)),
                      ],
                    ),
                    onTap: () {
                      controller.onProjectSelected(item);
                    },
                  ),
                  const Divider(),
                ],
              );
            }),
      ),
    ),
  );
}

Widget _membersWidget(List<Member> members, GroupsController controller) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.listMembers(),
      child: HttpFutureBuilder(
        state: controller.membersState.value,
        child: ListView.builder(
            controller: controller.scrollControllerMembers,
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
  );
}
