import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../home_controller.dart';

class ProjectsTab extends GetView<HomeController> {
  const ProjectsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _listWidget());
  }

  Widget _listWidget() {
    return RefreshIndicator(
      onRefresh: () => controller.listProjects(),
      child: HttpFutureBuilder(
        state: controller.projectsState.value,
        child: Scrollbar(
          controller: controller.projectsScrollController,
          child: ListView.builder(
              controller: controller.projectsScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.projects.length,
              itemBuilder: (context, index) {
                var item = controller.projects[index];

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

                return Column(
                  children: [
                    ListTile(
                      contentPadding:
                          CommonConstants.contentPaddingLitTileLarge,
                      leading: avatar,
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: item.namespace!.fullPath! + '/',
                                style: const TextStyle()),
                            TextSpan(
                                text: item.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
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
}
