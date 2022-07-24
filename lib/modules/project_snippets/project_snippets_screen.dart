import 'package:file_icon/file_icon.dart';
import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'project_snippets.dart';

class ProjectSnippetsScreen extends GetView<ProjectSnippetsController> {
  const ProjectSnippetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget());
  }

  Widget _buildWidget() {
    // ignore: unused_local_variable
    var l = controller.snippets.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Snippets".tr),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.createSnippet);
            },
            icon: const Icon(Icons.add),
            tooltip: 'Add snippet'.tr,
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () => controller.list(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: controller.scrollController,
          child: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.snippets.length,
              itemBuilder: (context, index) {
                var item = controller.snippets[index];
                return _buildListItem(item, context);
              }),
        ),
      ),
    );
  }

  Widget _buildListItem(ProjectSnippet item, BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: FileIcon(item.fileName!, size: 30),
          title: Text(
            item.title!,
            style:
                const TextStyle(fontWeight: CommonConstants.fontWeightListTile),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "authored " +
                            timeago.format(item.createdAt!) +
                            " by "),
                    TextSpan(text: item.author!.name, style: const TextStyle()),
                  ],
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          onTap: () {
            controller.onSelected(item);
          },
        ),
        const Divider(),
      ],
    );
  }
}
