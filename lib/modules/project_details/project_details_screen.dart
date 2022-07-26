import 'package:file_icon/file_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/project_details/project_menu_item.dart';
import 'package:gitplus_for_gitlab/modules/tree_view/tree_view.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'project_details.dart';

enum ProjectDetailsScreenPopup { edit, share, webUrl, delete }

class ProjectDetailsScreen extends GetView<ProjectDetailsController> {
  const ProjectDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    var project = controller.repository.project.value;
    if (project.id == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const LoadingWidget(),
      );
    }

    const spacing = 8.0;

    Widget visibility = Container();
    switch (project.visibility) {
      case GitLabVisibility.public:
        visibility = _iconLabel(Icons.public, "Public".tr);
        break;
      case GitLabVisibility.internal:
        visibility = _iconLabel(Icons.lock_outline, "Internal".tr);
        break;
      case GitLabVisibility.private:
        visibility = _iconLabel(Icons.lock_outline, "Private".tr);
        break;
    }

    Widget avatar;
    if (project.avatarUrl != null && project.avatarUrl!.isNotEmpty) {
      avatar = ListAvatar(avatarUrl: project.avatarUrl!);
    } else {
      avatar = CircleAvatar(
          child: Text(project.name!.toUpperCase().substring(0, 2)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name ?? ""),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) =>
                <PopupMenuEntry<ProjectDetailsScreenPopup>>[
              if (controller.canModifyOrDelete.value)
                PopupMenuItem(
                    value: ProjectDetailsScreenPopup.edit,
                    child: Text('Edit'.tr)),
              PopupMenuItem(
                  value: ProjectDetailsScreenPopup.share,
                  child: Text('Share'.tr)),
              PopupMenuItem(
                  value: ProjectDetailsScreenPopup.webUrl,
                  child: Text('Open in web browser'.tr)),
              if (controller.canModifyOrDelete.value) const PopupMenuDivider(),
              if (controller.canModifyOrDelete.value)
                PopupMenuItem(
                    value: ProjectDetailsScreenPopup.delete,
                    child: Text(
                      'Delete'.tr,
                      style: const TextStyle(color: Colors.red),
                    )),
            ],
            onSelected: (ProjectDetailsScreenPopup value) =>
                controller.onPopupSelected(value, context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.onRefreshAll(),
        child: ListView(
          shrinkWrap: true,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        avatar,
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(project.nameWithNamespace!,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        visibility,
                        const SizedBox(width: 10),

                        /// stars
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  controller.starUnstar();
                                },
                                icon: Icon(controller.starred.value
                                    ? Icons.star
                                    : Icons.star_border)),
                            const SizedBox(width: 5),
                            Text(project.starCount.toString() + " stars"),
                          ],
                        ),

                        /// forks
                        const SizedBox(width: 10),
                        _iconLabel(Octicons.git_branch,
                            project.forksCount.toString() + " forks"),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            ///

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(children: [
                  IntrinsicHeight(
                    child: Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Icons.event,
                        text: 'Activity',
                        onPressed: () {
                          Get.toNamed(Routes.projectActivity);
                        },
                      )),
                      SizedBox(width: spacing),
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Octicons.issue_opened,
                        text: 'Issues',
                        onPressed: () {
                          Get.toNamed(Routes.issues);
                        },
                      )),
                      SizedBox(width: spacing),
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Octicons.milestone,
                        text: 'Milestones',
                        onPressed: () {
                          Get.toNamed(Routes.milestones);
                        },
                      )),
                    ]),
                  ),
                  SizedBox(height: spacing),
                  IntrinsicHeight(
                    child: Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Octicons.git_merge,
                        text: 'MR',
                        onPressed: () {
                          Get.toNamed(Routes.mergeRequests);
                        },
                      )),
                      SizedBox(width: spacing),
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Icons.label_outline,
                        text: 'Labels',
                        onPressed: () {
                          Get.toNamed(Routes.labels);
                        },
                      )),
                      SizedBox(width: spacing),
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Icons.text_snippet_outlined,
                        text: 'Snippets',
                        onPressed: () {
                          Get.toNamed(Routes.projectSnippets);
                        },
                      )),
                    ]),
                  ),
                  SizedBox(height: spacing),
                  IntrinsicHeight(
                    child: Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Icons.star,
                        text: 'Starrers',
                        onPressed: () {
                          Get.toNamed(Routes.starrers);
                        },
                      )),
                      SizedBox(width: spacing),
                      Expanded(
                          child: ProjectMenuItemWidget(
                        icon: Icons.people,
                        text: 'Members',
                        onPressed: () {
                          controller.repository.membersFor = MembersFor.project;
                          Get.toNamed(Routes.projectMembers);
                        },
                      )),
                      SizedBox(width: spacing),
                      Expanded(child: Container()),
                    ]),
                  ),
                  SizedBox(height: spacing),
                  Flex(direction: Axis.horizontal, children: [
                    Expanded(
                        child: ProjectMenuItemWidget(
                      icon: Icons.code,
                      text: 'Browse code',
                      onPressed: () {
                        Get.toNamed(Routes.treeViewRoot,
                            arguments: TreeViewArgs(
                                name: project.name ?? "", path: ""));
                      },
                    )),
                    SizedBox(width: spacing),
                    Expanded(
                        child: ProjectMenuItemWidget(
                      icon: Octicons.git_commit,
                      text: 'Commits',
                      onPressed: () {
                        Get.toNamed(Routes.commits);
                      },
                    )),
                  ]),
                ]),
              ),
            ),

            if (controller.readmeConent.isNotEmpty)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            FileIcon(controller.readmeFilename.value, size: 30),
                            const SizedBox(width: 15),
                            Flexible(
                              child: Text(
                                controller.readmeFilename.value,
                                style: const TextStyle(
                                    fontFamily: 'SourceCodePro'),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (controller.readmeConent.isNotEmpty)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppMarkdown(content: controller.readmeConent.string),
                ),
              ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _iconLabel(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
