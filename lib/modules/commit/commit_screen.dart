import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import 'package:get/get.dart';

import 'commit_controller.dart';

enum CommitScreenPopupActions { openWeb, browseFiles, share, settings }

class CommitScreen extends GetView<CommitController> {
  const CommitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget());
  }

  Widget _buildWidget() {
    controller.refreshUI.value;

    var codetheme = "";
    codetheme = Get.isDarkMode ? AppCodeTheme.dark : AppCodeTheme.light;

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.repository.commit.value.shortId!),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) =>
                <PopupMenuEntry<CommitScreenPopupActions>>[
              const PopupMenuItem(
                  value: CommitScreenPopupActions.browseFiles,
                  child: Text('Browse code')),
              const PopupMenuItem(
                  value: CommitScreenPopupActions.openWeb,
                  child: Text('Open in web browser')),
              const PopupMenuItem(
                  value: CommitScreenPopupActions.share, child: Text('Share')),
              const PopupMenuDivider(),
              PopupMenuItem(
                  value: CommitScreenPopupActions.settings,
                  child: Text('View code options'.tr)),
            ],
            onSelected: (CommitScreenPopupActions value) =>
                controller.onPopupSelected(value),
          ),
        ],
      ),
      body: _buildList(codetheme),
    );
  }

  Widget _buildList(codetheme) {
    return RefreshIndicator(
      onRefresh: () => controller.getDiff(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: controller.scrollController,
          child: ListView.builder(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.diff.length,
            itemBuilder: (context, index) {
              var item = controller.diff[index];
              return StickyHeader(
                  header: _buildDiffTitle(item),
                  content: SafeArea(
                      bottom: false,
                      child: _buildDiff(item, context, codetheme)));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDiff(Diff item, BuildContext context, codetheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: AppHighlightView(
              content: item.diff,
              lang: 'diff',
              theme: codetheme,
              lineNumbers: false,
              fontSize: controller.spStorage.getFontSize().value.toDouble(),
            )),
        // SizedBox(height: 10)
      ],
    );
  }

  Widget _buildDiffTitle(Diff item) {
    Widget title;

    var style = const TextStyle(fontWeight: FontWeight.bold);

    if (item.deletedFile!) {
      title = Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'Deleted file: ', style: style),
            TextSpan(text: item.newPath, style: style),
          ],
        ),
      );
    } else if (item.newFile!) {
      title = Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'New file: ', style: style),
            TextSpan(text: item.newPath, style: style),
          ],
        ),
      );
    } else if (item.renamedFile!) {
      if (item.diff!.isEmpty) {
        title = Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'File moved: ', style: style),
              TextSpan(text: item.oldPath, style: style),
              TextSpan(text: ' -> ', style: style),
              TextSpan(text: item.newPath, style: style),
            ],
          ),
        );
      } else {
        title = Text.rich(
          TextSpan(
            children: [
              TextSpan(text: item.oldPath, style: style),
              TextSpan(text: ' -> ', style: style),
              TextSpan(text: item.newPath, style: style),
            ],
          ),
        );
      }
    } else {
      title = Text.rich(
        TextSpan(
          children: [
            TextSpan(text: item.newPath, style: style),
          ],
        ),
      );
    }
    return Material(
      child: Column(
        children: [
          const Divider(),
          ListTile(
            tileColor: Get.theme.cardColor,
            title: title,
            onTap: () {
              controller.onFileSelected(item);
            },
            trailing: !item.deletedFile!
                ? const Icon(Icons.keyboard_arrow_right)
                : null,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
