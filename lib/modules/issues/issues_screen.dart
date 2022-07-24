import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'issues.dart';

class IssuesScreen extends GetView<IssuesController> {
  const IssuesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var l = controller.issues.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Issues".tr),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (c) {
                    String selectedScopeRadio =
                        controller.issuesFilterScope.value;
                    String selectedStateRadio =
                        controller.issuesFilterState.value;
                    return AlertDialog(
                      title: Text('Filter'.tr),
                      content: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Wrap(
                                spacing: 5,
                                runSpacing: -5,
                                children: [
                                  FilterChip(
                                    label: Text('All'.tr),
                                    selected: selectedStateRadio.isEmpty,
                                    onSelected: (value) {
                                      setState(() => selectedStateRadio = '');
                                      controller.onIssuesStateChanged('');
                                    },
                                  ),
                                  FilterChip(
                                    label: Text('Open'.tr),
                                    selected:
                                        selectedStateRadio == IssueState.opened,
                                    onSelected: (value) {
                                      setState(() => selectedStateRadio =
                                          IssueState.opened);
                                      controller.onIssuesStateChanged(
                                          IssueState.opened);
                                    },
                                  ),
                                  FilterChip(
                                    label: Text('Closed'.tr),
                                    selected:
                                        selectedStateRadio == IssueState.closed,
                                    onSelected: (value) {
                                      setState(() => selectedStateRadio =
                                          IssueState.closed);
                                      controller.onIssuesStateChanged(
                                          IssueState.closed);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text('Scope'.tr),
                              const SizedBox(height: 5),
                              Wrap(
                                spacing: 5,
                                children: [
                                  FilterChip(
                                    label: Text('All'.tr),
                                    selected: selectedScopeRadio ==
                                        MergeRequestScope.all,
                                    onSelected: (value) {
                                      setState(() => selectedScopeRadio =
                                          MergeRequestScope.all);
                                      controller.onIssuesScopeChanged(
                                          MergeRequestScope.all);
                                    },
                                  ),
                                  FilterChip(
                                    label: Text('Created'.tr),
                                    selected: selectedScopeRadio ==
                                        MergeRequestScope.createdByMe,
                                    onSelected: (value) {
                                      setState(() => selectedScopeRadio =
                                          MergeRequestScope.createdByMe);
                                      controller.onIssuesScopeChanged(
                                          MergeRequestScope.createdByMe);
                                    },
                                  ),
                                  FilterChip(
                                    label: Text('Assigned'.tr),
                                    selected: selectedScopeRadio ==
                                        MergeRequestScope.assignedToMe,
                                    onSelected: (value) {
                                      setState(() => selectedScopeRadio =
                                          MergeRequestScope.assignedToMe);
                                      controller.onIssuesScopeChanged(
                                          MergeRequestScope.assignedToMe);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Close'.tr)),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter',
          ),
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: IssuesDataSearch(
                      (s) {
                        controller.onSearchIssuesTextChanged(s);
                      },
                      controller,
                    ));
              },
              tooltip: 'Search'.tr,
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                controller.onNavToNewIssue();
              },
              tooltip: 'Create an issue'.tr,
              icon: const Icon(Icons.add)),
        ],
      ),
      body: _buildList(
          controller, controller.scrollController, controller.issues),
    );
  }
}

class IssuesDataSearch extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final IssuesController controller;

  IssuesDataSearch(this.onSearchTextChanged, this.controller)
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
    return _buildList(
        controller, controller.scrollFoundController, controller.foundIssues);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _buildList(
        controller, controller.scrollFoundController, controller.foundIssues);
  }
}

Widget _buildList(IssuesController controller,
    ScrollController scrollController, List<Issue> items) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.list(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: scrollController,
          child: ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];
                return _buildListItem(controller, item, context);
              }),
        ),
      ),
    ),
  );
}

Widget _buildListItem(
    IssuesController controller, Issue item, BuildContext context) {
  return Column(
    children: [
      ListTile(
        contentPadding: CommonConstants.contentPaddingLitTileLarge,
        leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
        title: Text(
          '#' + item.iid.toString() + ' ' + item.title!,
          style:
              const TextStyle(fontWeight: CommonConstants.fontWeightListTile),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(
              children: [
                TextSpan(
                    text: item.author!.name,
                    style: const TextStyle(fontSize: 14)),
                TextSpan(
                    text: " authored " + timeago.format(item.createdAt!),
                    style: const TextStyle(fontSize: 14)),
              ],
            )),
            const SizedBox(height: 5),
            Row(
              children: [
                _stateWidget(item),

                const SizedBox(width: 15),

                /// mr
                const Icon(Octicons.git_merge, size: 18),
                const SizedBox(width: 3),
                Text(item.mergeRequestsCount.toString(),
                    style: const TextStyle(fontSize: 12)),

                const SizedBox(width: 10),

                /// comments
                const Icon(Octicons.comment_discussion, size: 18),
                const SizedBox(width: 5),
                Text(item.userNotesCount.toString(),
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        onTap: () {
          controller.onNavToDetails(item);
        },
      ),
      const Divider(),
    ],
  );
}

Widget _stateWidget(Issue item) {
  return ColorLabel(
    color: item.state == IssueState.opened ? Colors.green : Colors.red,
    text: item.state == IssueState.opened ? "Open".tr : "Closed".tr,
    fontSize: 12,
  );
}
