import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'branches.dart';

class BranchesScreenArgs {
  final Function(String) onRefSelected;
  final String selectedRef;
  final String returnRoute;

  BranchesScreenArgs({
    required this.onRefSelected,
    required this.selectedRef,
    required this.returnRoute,
  });
}

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen>
    with SingleTickerProviderStateMixin {
  final BranchesScreenArgs _args = Get.arguments;
  late final TabController _tabController;
  late final _controller = Get.find<BranchesController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = _controller.tabControlIndex.value;
    _tabController.addListener(() => _tabChangedListener(_tabController.index));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(() => _tabChangedListener);
    _tabController.dispose();
    _controller.groupDetailsDisposed();
  }

  void _tabChangedListener(int index) {
    _controller.onTabChanged(_tabController.index);

    if (_tabController.index == 0) {
      if (_controller.branches.isNotEmpty) {
        return;
      }
      _controller.list();
    } else {
      if (_controller.tags.isNotEmpty) {
        return;
      }
      _controller.listTags();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(BuildContext context) {
    List<Widget> actions;
    if (_controller.tabControlIndex.value == 0) {
      actions = [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: BranchesDataSearch((s) {
                    _controller.onSearchBranchesTextChanged(s);
                  }, _controller, _args));
            },
            icon: const Icon(Icons.search))
      ];
    } else {
      actions = [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: TagsDataSearch((s) {
                    _controller.onSearchTagsTextChanged(s);
                  }, _controller, _args));
            },
            icon: const Icon(Icons.search))
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Branches"),
        actions: actions,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: const [
            Tab(text: "Branches"),
            Tab(text: "Tags"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _listBranchesWidget(_controller.branches, _controller, _args),
          _listTagsWidget(_controller.tags, _controller, _args),
        ],
      ),
    );
  }
}

class BranchesDataSearch extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final BranchesController controller;
  late BranchesScreenArgs args;

  BranchesDataSearch(this.onSearchTextChanged, this.controller, this.args)
      : super(searchFieldStyle: const TextStyle(color: Colors.grey));

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close)),
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
    return _listBranchesWidget(controller.foundBranches, controller, args);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _listBranchesWidget(controller.foundBranches, controller, args);
  }
}

class TagsDataSearch extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final BranchesController controller;
  late BranchesScreenArgs args;

  TagsDataSearch(this.onSearchTextChanged, this.controller, this.args)
      : super(searchFieldStyle: const TextStyle(color: Colors.grey));

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close)),
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
    return _listTagsWidget(controller.foundTags, controller, args);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _listTagsWidget(controller.foundTags, controller, args);
  }
}

Widget _listBranchesWidget(List<Branch> branches, BranchesController controller,
    BranchesScreenArgs args) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.list(),
      child: HttpFutureBuilder(
        state: controller.stateBranch.value,
        child: Scrollbar(
          controller: controller.scrollControllerBranches,
          child: ListView.builder(
              controller: controller.scrollControllerBranches,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: branches.length,
              itemBuilder: (context, index) {
                var b = branches[index];

                Widget def = Container();
                if (controller.repository.project.value.defaultBranch ==
                    b.name) {
                  def = Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Get.theme.highlightColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: const Text('DEFAULT',
                          style: TextStyle(fontSize: 12)));
                }

                return Column(
                  children: [
                    ListTile(
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(b.name! + " ",
                              style:
                                  const TextStyle(fontFamily: 'SourceCodePro')),
                          def,
                        ],
                      ),
                      trailing: b.name == args.selectedRef
                          ? Icon(Icons.done,
                              color: Get.theme.colorScheme.secondary)
                          : null,
                      onTap: () {
                        args.onRefSelected(b.name ?? '');
                        Get.until(
                            (route) => route.settings.name == args.returnRoute);
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

Widget _listTagsWidget(
    List<Tag> items, BranchesController controller, BranchesScreenArgs args) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.listTags(),
      child: HttpFutureBuilder(
        state: controller.stateTags.value,
        child: Scrollbar(
          controller: controller.scrollControllerTags,
          child: ListView.builder(
              controller: controller.scrollControllerTags,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                var b = items[index];

                Widget def = Container();
                if (controller.repository.project.value.defaultBranch ==
                    b.name) {
                  def = Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Get.theme.highlightColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: const Text('DEFAULT',
                          style: TextStyle(fontSize: 12)));
                }

                return Column(
                  children: [
                    ListTile(
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(b.name! + " ",
                              style:
                                  const TextStyle(fontFamily: 'SourceCodePro')),
                          def,
                        ],
                      ),
                      trailing: b.name == args.selectedRef
                          ? Icon(Icons.done,
                              color: Get.theme.colorScheme.secondary)
                          : null,
                      onTap: () {
                        args.onRefSelected(b.name ?? '');
                        Get.until(
                            (route) => route.settings.name == args.returnRoute);
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
