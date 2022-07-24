import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import 'milestones.dart';

class MilestonesScreenArgs {
  final Function(ProjectMilestone)? onSelected;
  MilestonesScreenArgs({this.onSelected});
}

class MilestonesScreen extends GetView<MilestonesController> {
  MilestonesScreen({Key? key}) : super(key: key);

  final MilestonesScreenArgs? args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var l = controller.milestones.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Milestones".tr),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (c) {
                    String selectedStateRadio = controller.filterState.value;
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
                                      controller.filterStateChanged('');
                                    },
                                  ),
                                  FilterChip(
                                    label: Text('Active'.tr),
                                    selected: selectedStateRadio ==
                                        MilestoneState.active,
                                    onSelected: (value) {
                                      setState(() => selectedStateRadio =
                                          MilestoneState.active);
                                      controller.filterStateChanged(
                                          MilestoneState.active);
                                    },
                                  ),
                                  FilterChip(
                                    label: Text('Closed'.tr),
                                    selected: selectedStateRadio ==
                                        MilestoneState.closed,
                                    onSelected: (value) {
                                      setState(() => selectedStateRadio =
                                          MilestoneState.closed);
                                      controller.filterStateChanged(
                                          MilestoneState.closed);
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
                    delegate: MilestonesDataSearch(
                      (s) {
                        controller.onSearchIssuesTextChanged(s);
                      },
                      controller,
                      args,
                    ));
              },
              tooltip: 'Search a milestone'.tr,
              icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.createMilestone);
            },
            icon: const Icon(Icons.add),
            tooltip: 'New milestone'.tr,
          ),
        ],
      ),
      body: _buildList(
          controller, controller.scrollController, controller.milestones, args),
    );
  }
}

Widget _buildList(
    MilestonesController controller,
    ScrollController scrollController,
    List<ProjectMilestone> items,
    MilestonesScreenArgs? args) {
  return Obx(
    () => RefreshIndicator(
      onRefresh: () => controller.list(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: scrollController,
          child: ListView.builder(
              itemCount: items.length,
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var item = items[index];
                return _buildListItem(controller, item, context, args);
              }),
        ),
      ),
    ),
  );
}

Widget _buildListItem(MilestonesController controller, ProjectMilestone item,
    BuildContext context, MilestonesScreenArgs? args) {
  return Column(
    children: [
      ListTile(
        contentPadding: CommonConstants.contentPaddingLitTileLarge,
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          if (args?.onSelected == null) {
            controller.onSelected(item);
          } else {
            args!.onSelected!(item);
            Get.back();
          }
        },
        title: Text(
          item.title!,
          style:
              const TextStyle(fontWeight: CommonConstants.fontWeightListTile),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            if (item.expired ?? false)
              Text("expired " + DateFormat('yyyy-MM-dd').format(item.dueDate!))
            else
              Row(
                children: [
                  if (item.startDate != null)
                    Flexible(
                        child: Text(DateFormat('MMM dd, yyyy - ')
                            .format(item.startDate!))),
                  if (item.dueDate != null)
                    Flexible(
                        child: Text(
                            DateFormat('MMM dd, yyyy').format(item.dueDate!))),
                ],
              ),
            const SizedBox(height: 5),
            MilestoneStateLabel(
              item: item,
              fontSize: 12,
            ),
          ],
        ),
      ),
      const Divider(),
    ],
  );
}

class MilestonesDataSearch extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final MilestonesController controller;
  late final MilestonesScreenArgs? args;

  MilestonesDataSearch(this.onSearchTextChanged, this.controller, this.args)
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
    return _buildList(controller, controller.scrollFoundController,
        controller.foundMilestones, args);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _buildList(controller, controller.scrollFoundController,
        controller.foundMilestones, args);
  }
}
