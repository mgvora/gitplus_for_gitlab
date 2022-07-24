import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'issue.dart';

enum IssueScreenPopupActions { edit, reopen, close, delete, share, openWeb }

class IssueScreen extends GetView<IssueController> {
  const IssueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    var item = controller.repository.issue.value;
    var title = controller.repository.issue.value.iid ?? '';
    var project = controller.repository.project.value;
    // ignore: unused_local_variable
    var l = controller.issues.length;

    Widget avatar = Container();
    if (project.avatarUrl != null && project.avatarUrl!.isNotEmpty) {
      avatar = ListAvatar(avatarUrl: project.avatarUrl!);
    } else if (project.id != null) {
      avatar = CircleAvatar(
          child: Text(project.name!.toUpperCase().substring(0, 2)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('#' + title.toString()),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<IssueScreenPopupActions>>[
              PopupMenuItem(
                  value: IssueScreenPopupActions.edit, child: Text('Edit'.tr)),
              item.state == IssueState.opened
                  ? PopupMenuItem(
                      value: IssueScreenPopupActions.close,
                      child: Text('Close'.tr))
                  : PopupMenuItem(
                      value: IssueScreenPopupActions.reopen,
                      child: Text('Reopen'.tr)),
              PopupMenuItem(
                  value: IssueScreenPopupActions.share,
                  child: Text('Share'.tr)),
              PopupMenuItem(
                  value: IssueScreenPopupActions.openWeb,
                  child: Text('Open in web browser'.tr)),
              const PopupMenuDivider(),
              PopupMenuItem(
                  value: IssueScreenPopupActions.delete,
                  child: Text('Delete'.tr,
                      style: const TextStyle(color: Colors.red))),
            ],
            onSelected: (IssueScreenPopupActions value) =>
                controller.onPopupSelected(value, context),
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => controller.onRefresh(),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (controller.repository.loadProjectRequired.value &&
                              project.id != null)
                            Row(
                              children: [
                                avatar,
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text: project.namespace!.fullPath! +
                                                '/',
                                            style:
                                                const TextStyle(fontSize: 18)),
                                        TextSpan(
                                            text: project.name,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (controller.repository.loadProjectRequired.value &&
                              project.id != null)
                            const Divider(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(item.title ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                              _stateWidget(item),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (item.author != null)
                            Text(item.author!.name! +
                                ' opened this issue ' +
                                timeago.format(item.createdAt!) +
                                ', updated ' +
                                timeago.format(item.updatedAt!)),
                          if (item.description != null &&
                              item.description!.isNotEmpty)
                            const Divider(height: 25),
                          if (item.description != null &&
                              item.description!.isNotEmpty)
                            SafeArea(
                              child: AppMarkdown(content: item.description!),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.repository.issueLabels.isNotEmpty)
                    Card(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _headerLabel('Labels'),
                            Wrap(
                              spacing: 5,
                              children: [
                                for (var item
                                    in controller.repository.issueLabels)
                                  _labelWidget(item),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Octicons.note),
                    title: Text('Notes'.tr,
                        style: const TextStyle(
                            fontWeight: CommonConstants.fontWeightListTile)),
                    onTap: () {
                      Get.toNamed(Routes.issueNotes);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item.userNotesCount.toString()),
                        const Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Octicons.git_merge),
                    title: Text('Related merge requests'.tr,
                        style: const TextStyle(
                            fontWeight: CommonConstants.fontWeightListTile)),
                    onTap: () {
                      Get.toNamed(Routes.issueRelatedRequests);
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item.mergeRequestsCount.toString()),
                        const Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelWidget(ProjectLabel item) {
    return ColorLabel(
      color: hexToColor(item.color!),
      text: item.name!,
    );
  }

  Widget _stateWidget(Issue item) {
    item.state == IssueState.opened ? Colors.green : Colors.red;
    return ColorLabel(
      color: item.state == IssueState.opened ? Colors.green : Colors.red,
      text: item.state == IssueState.opened ? "Open".tr : "Closed".tr,
    );
  }
}

Widget _headerLabel(String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5)
    ],
  );
}
