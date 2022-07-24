import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/projects/projects.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.find<ProjectsController>();

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      _controller.onTabChanged(_tabController.index);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CrossFade<String>(
          initialData: '',
          data: 'Projects',
          builder: (value) => Text(value),
        ),
        actions: [
          IconButton(
            onPressed: () {
              switch (_tabController.index) {
                case 0:
                  showSearch(
                      context: context,
                      delegate: ProjectsDataSearch(
                        _controller,
                        _controller.foundAll,
                        () => Future.delayed(const Duration(milliseconds: 1)),
                        (s) => _controller.onSearchAllTextChanged(s),
                        _controller.scrollControllerSearchAll,
                        _controller.stateAll,
                      ));
                  break;
                case 1:
                  showSearch(
                      context: context,
                      delegate: ProjectsDataSearch(
                        _controller,
                        _controller.foundPersonal,
                        () => Future.delayed(const Duration(milliseconds: 1)),
                        (s) => _controller.onSearchPersonalTextChanged(s),
                        _controller.scrollControllerSearchPersonal,
                        _controller.statePersonal,
                      ));
                  break;
                case 2:
                  showSearch(
                      context: context,
                      delegate: ProjectsDataSearch(
                        _controller,
                        _controller.foundStarred,
                        () => Future.delayed(const Duration(milliseconds: 1)),
                        (s) => _controller.onSearchStarredTextChanged(s),
                        _controller.scrollControllerSearchStarred,
                        _controller.stateStarred,
                      ));
                  break;
                case 3:
                  showSearch(
                      context: context,
                      delegate: ProjectsDataSearch(
                        _controller,
                        _controller.foundPublic,
                        () => Future.delayed(const Duration(milliseconds: 1)),
                        (s) => _controller.onSearchPublicTextChanged(s),
                        _controller.scrollControllerSearchPublic,
                        _controller.statePublic,
                      ));
                  break;
              }
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search'.tr,
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.createProject);
            },
            icon: const Icon(Icons.add),
            tooltip: 'New project'.tr,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            Tab(text: "All".tr),
            Tab(text: "Personal".tr),
            Tab(text: "Starred".tr),
            Tab(text: "Explore".tr),
          ],
        ),
      ),
      drawer: AppDrawer(
        selected: _controller.selectedItem,
        account: _controller.repository.account.value,
        repository: _controller.repository,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _listWidget(
              controller: _controller,
              p: _controller.all,
              onRefresh: () => _controller.listAll(),
              scrollController: _controller.scrollControllerAll,
              state: _controller.stateAll),
          _listWidget(
              controller: _controller,
              p: _controller.personal,
              onRefresh: () => _controller.listPersonal(),
              scrollController: _controller.scrollControllerPersonal,
              state: _controller.statePersonal),
          _listWidget(
              controller: _controller,
              p: _controller.starred,
              onRefresh: () => _controller.listStarred(),
              scrollController: _controller.scrollControllerStarred,
              state: _controller.stateStarred),
          _listWidget(
              controller: _controller,
              p: _controller.public,
              onRefresh: () => _controller.listPublic(),
              scrollController: _controller.scrollControllerPublic,
              state: _controller.statePublic),
        ],
      ),
    );
  }
}

class ProjectsDataSearch extends SearchDelegate<String> {
  final ProjectsController controller;
  final List<Project> filteredProjects;
  final Future<void> Function() onRefresh;
  final Function(String) onSearchTextChanged;
  final ScrollController scrollController;
  final Rx<HttpState> state;

  ProjectsDataSearch(
    this.controller,
    this.filteredProjects,
    this.onRefresh,
    this.onSearchTextChanged,
    this.scrollController,
    this.state,
  ) : super(
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
    onSearchTextChanged(query);
    return _listWidget(
        controller: controller,
        p: filteredProjects,
        onRefresh: onRefresh,
        scrollController: scrollController,
        state: state);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _listWidget(
        controller: controller,
        p: filteredProjects,
        onRefresh: onRefresh,
        scrollController: scrollController,
        state: state);
  }
}

Widget _listWidget({
  required ProjectsController controller,
  required List<Project> p,
  required Future<void> Function() onRefresh,
  required ScrollController scrollController,
  required Rx<HttpState> state,
}) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: onRefresh,
      child: HttpFutureBuilder(
        state: state.value,
        child: ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: p.length,
            itemBuilder: (context, index) {
              var item = p[index];

              Widget avatar;
              if (item.avatarUrl != null && item.avatarUrl!.isNotEmpty) {
                avatar = ListVisibilityImageAvatar(
                    avatarUrl: item.avatarUrl!, visibility: item.visibility!);
              } else {
                var name = "";
                if (item.name != null && item.name!.length > 1) {
                  name = item.name!.toUpperCase().substring(0, 2);
                } else {
                  name = item.name!.toUpperCase().substring(0, 1);
                }
                avatar = ListVisibilityTextAvatar(
                    text: name, visibility: item.visibility!);
              }

              IconData? iconVis;

              if (item.visibility == GitLabVisibility.private) {
                iconVis = Icons.lock_outline;
              } else if (item.visibility == GitLabVisibility.internal) {
                iconVis = Icons.lock_outline;
              } else {
                iconVis = Icons.public;
              }

              var vis = Icon(iconVis, size: 15);

              return Column(
                children: [
                  ListTile(
                    contentPadding: CommonConstants.contentPaddingLitTileLarge,
                    leading: avatar,
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: item.namespace!.fullPath! + '/',
                              style: const TextStyle()),
                          TextSpan(
                              text: item.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // trailing: vis,
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
