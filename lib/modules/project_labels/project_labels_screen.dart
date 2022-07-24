import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'project_labels.dart';

class ProjectLabelsScreenArgs {
  final Function(ProjectLabel)? onSelected;
  final String parentRoute;
  ProjectLabelsScreenArgs({this.onSelected, required this.parentRoute});
}

class ProjectLabelsScreen extends GetView<ProjectLabelsController> {
  ProjectLabelsScreen({Key? key}) : super(key: key);

  final ProjectLabelsScreenArgs? args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var l = controller.labels.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Labels".tr),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: LabelsDataSearch(
                      (s) {
                        controller.onSearchIssuesTextChanged(s);
                      },
                      controller,
                      args,
                    ));
              },
              tooltip: 'Search'.tr,
              icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              controller.navigateToAddScreen();
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add label'.tr,
          ),
        ],
      ),
      body: _buildList(
          controller, controller.scrollController, args, controller.labels),
    );
  }
}

class LabelsDataSearch extends SearchDelegate<String> {
  late final Function(String) onSearchTextChanged;
  late final ProjectLabelsController controller;
  late final ProjectLabelsScreenArgs? args;

  LabelsDataSearch(
    this.onSearchTextChanged,
    this.controller,
    this.args,
  ) : super(
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
          controller.setPage(0);
          Get.back();
        },
        icon: searchLeadingIcon());
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearchTextChanged(query);
    return _buildList(
        controller, controller.scrollFoundController, args, controller.found);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearchTextChanged(query);
    return _buildList(
        controller, controller.scrollFoundController, args, controller.found);
  }
}

Widget _buildList(
    ProjectLabelsController controller,
    ScrollController scrollController,
    ProjectLabelsScreenArgs? args,
    List<ProjectLabel> items) {
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
                return _buildListItem(item, context, controller, args);
              }),
        ),
      ),
    ),
  );
}

Widget _buildListItem(ProjectLabel item, BuildContext context,
    ProjectLabelsController controller, ProjectLabelsScreenArgs? args) {
  return Column(
    children: [
      ListTile(
        onTap: () {
          if (args?.onSelected == null) {
            controller.navigateToEditScreen(item);
          } else {
            args!.onSelected!(item);
            Get.back();
          }
        },
        title: Align(
            alignment: Alignment.topLeft,
            child: ColorLabel(
              color: hexToColor(item.color!),
              text: item.name!,
              padding:
                  const EdgeInsets.only(left: 10, top: 3, right: 10, bottom: 3),
            )),
        subtitle: item.description != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                child: Text(item.description!),
              )
            : null,
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
      const Divider(),
    ],
  );
}
