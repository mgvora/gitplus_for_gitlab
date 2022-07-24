import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

import 'milestone.dart';

enum MilestoneScreenPopupActions { edit, close, reopen, delete }

class MilestoneScreen extends GetView<MilestoneController> {
  const MilestoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    var item = controller.repository.milestone.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title ?? ''),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) =>
                <PopupMenuEntry<MilestoneScreenPopupActions>>[
              PopupMenuItem(
                  value: MilestoneScreenPopupActions.edit,
                  child: Text('Edit'.tr)),
              item.state == MilestoneState.active
                  ? PopupMenuItem(
                      value: MilestoneScreenPopupActions.close,
                      child: Text('Close'.tr))
                  : PopupMenuItem(
                      value: MilestoneScreenPopupActions.reopen,
                      child: Text('Reopen'.tr)),
              const PopupMenuDivider(),
              PopupMenuItem(
                  value: MilestoneScreenPopupActions.delete,
                  child: Text(
                    'Delete'.tr,
                    style: const TextStyle(color: Colors.red),
                  )),
            ],
            onSelected: (MilestoneScreenPopupActions value) =>
                controller.onPopupSelected(value, context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: SafeArea(
          bottom: false,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// state
                          Row(
                            children: [
                              MilestoneStateLabel(item: item),
                              const SizedBox(width: 10),
                              if (item.startDate != null)
                                Flexible(
                                    child: Text(DateFormat('MMM dd, yyyy - ')
                                        .format(item.startDate!))),
                              if (item.dueDate != null)
                                Flexible(
                                    child: Text(DateFormat('MMM dd, yyyy')
                                        .format(item.dueDate!))),
                            ],
                          ),

                          /// completion

                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                              value: controller.completePercProgress.value,
                              color: controller.completePercProgress.value == 1
                                  ? Colors.green
                                  : null),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text.rich(
                                  TextSpan(
                                    style: const TextStyle(),
                                    children: [
                                      TextSpan(
                                          text: controller.issues.length
                                              .toString()),
                                      if (controller.issues.length == 1)
                                        const TextSpan(text: ' Issue, ')
                                      else
                                        const TextSpan(text: ' Issues, '),
                                      TextSpan(
                                          text:
                                              controller.mr.length.toString()),
                                      if (controller.mr.length == 1)
                                        const TextSpan(text: ' Merge request')
                                      else
                                        const TextSpan(text: ' Merge requests')
                                    ],
                                  ),
                                ),
                              ),
                              Text(controller.completePerc.string +
                                  '% ' +
                                  'complete'),
                            ],
                          ),

                          /// description

                          if (item.description != null &&
                              item.description!.isNotEmpty)
                            const SizedBox(height: 15),
                          if (item.description != null &&
                              item.description!.isNotEmpty)
                            Text(item.description!),
                        ],
                      ),
                    ),
                  ),
                  if (controller.issues.isNotEmpty) _issues(),
                  const SizedBox(height: 10),
                  if (controller.mr.isNotEmpty) _mr(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerLabel(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _issues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerLabel('Related issues'.tr),
        const Divider(),
        for (var item in controller.issues) _issueListItem(item)
      ],
    );
  }

  Widget _issueListItem(Issue item) {
    return Column(
      children: [
        ListTile(
          leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
          trailing: const Icon(Icons.keyboard_arrow_right),
          title: Text(item.title!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _issueStateWidget(item),
            ],
          ),
          onTap: () {
            controller.navigateToIssue(item);
          },
        ),
        const Divider(),
      ],
    );
  }

  Widget _mr() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerLabel('Related merge requests'.tr),
        const Divider(),
        for (var item in controller.mr) _mrListItem(item)
      ],
    );
  }

  Widget _mrListItem(MergeRequest item) {
    return Column(
      children: [
        ListTile(
          leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
          trailing: const Icon(Icons.keyboard_arrow_right),
          title: Text(item.title!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              _mrStateWidget(item),
            ],
          ),
          onTap: () {
            controller.navigateToMr(item);
          },
        ),
        const Divider(),
      ],
    );
  }
}

Widget _issueStateWidget(Issue item) {
  return ColorLabel(
    color: item.state == IssueState.opened ? Colors.green : Colors.red,
    text: item.state == IssueState.opened ? "Open".tr : "Closed".tr,
    fontSize: 12,
  );
}

Widget _mrStateWidget(MergeRequest item) {
  return ColorLabel(
    color: item.state == MergeRequestState.opened ? Colors.green : Colors.red,
    text: item.state == MergeRequestState.opened ? "Open".tr : "Closed".tr,
    fontSize: 12,
  );
}
