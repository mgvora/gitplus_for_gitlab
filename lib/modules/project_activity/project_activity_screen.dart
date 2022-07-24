import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'project_activity.dart';

class ProjectActivityScreen extends GetView<ProjectActivityController> {
  const ProjectActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var l = controller.events.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity".tr),
      ),
      body: _listWidget(),
    );
  }

  Widget _listWidget() {
    return RefreshIndicator(
      onRefresh: () => controller.listActivities(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: controller.scrollController,
          child: ListView.builder(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.events.length,
              itemBuilder: (context, index) {
                var item = controller.events[index];
                return _buildListItem(item);
              }),
        ),
      ),
    );
  }

  Widget _buildListItem(Event item) {
    return Column(
      children: [
        ListTile(
          contentPadding: CommonConstants.contentPaddingLitTileLarge,
          leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: item.author!.name! + " ",
                    style: const TextStyle(
                        fontWeight: CommonConstants.fontWeightListTile)),
                TextSpan(
                    text: '@' + item.authorUsername!,
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          onTap: () {
            controller.onItemPressed(item);
          },
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventDescLabel.widget(item) ?? Container(),
              Text(timeago.format(item.createdAt!)),
              // Text(item.id!.toString()),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
