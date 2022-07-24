import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:path/path.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'project_snippet.dart';

enum ProjectSnippetScreenPopupActions { edit, delete, share, web }

class ProjectSnippetScreen extends GetView<ProjectSnippetController> {
  const ProjectSnippetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    var codetheme = "";
    codetheme = Get.isDarkMode ? AppCodeTheme.dark : AppCodeTheme.light;

    var item = controller.repository.snippet.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title!),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) =>
                <PopupMenuEntry<ProjectSnippetScreenPopupActions>>[
              PopupMenuItem(
                  value: ProjectSnippetScreenPopupActions.edit,
                  child: Text('Edit'.tr)),
              PopupMenuItem(
                  value: ProjectSnippetScreenPopupActions.share,
                  child: Text('Share'.tr)),
              PopupMenuItem(
                  value: ProjectSnippetScreenPopupActions.web,
                  child: Text('Open in web browser'.tr)),
              const PopupMenuDivider(),
              PopupMenuItem(
                  value: ProjectSnippetScreenPopupActions.delete,
                  child: Text('Delete'.tr,
                      style: const TextStyle(color: Colors.red))),
            ],
            onSelected: (ProjectSnippetScreenPopupActions value) =>
                controller.onPopupSelected(value, context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getSnippet(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    margin: const EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          /// title

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(item.title!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                              _stateWidget(item),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text('Created by ' +
                              item.author!.name! +
                              ' ' +
                              timeago.format(item.createdAt!)),

                          /// filename

                          if (item.fileName != null &&
                              item.fileName!.isNotEmpty)
                            const Divider(height: 15),
                          if (item.fileName != null &&
                              item.fileName!.isNotEmpty)
                            Text(item.fileName!),

                          /// description

                          if (item.description != null &&
                              item.description!.isNotEmpty)
                            const Divider(height: 15),
                          if (item.description != null &&
                              item.description!.isNotEmpty)
                            Text(item.description!),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: AppHighlightView(
                        content: controller.repository.snippetContent.value,
                        lang: extension(
                                controller.repository.snippet.value.fileName!)
                            .replaceAll(".", ""),
                        lineNumbers:
                            controller.spStorage.getShowLineNumbers().value,
                        theme: codetheme,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stateWidget(ProjectSnippet item) {
    var vis = '';
    if (item.visibility == GitLabVisibility.private) {
      vis = 'Private';
    } else if (item.visibility == GitLabVisibility.internal) {
      vis = 'Internal';
    } else {
      vis = 'Public';
    }
    return ColorLabel(
      color: Colors.grey.shade200,
      text: vis.tr,
    );
  }
}
