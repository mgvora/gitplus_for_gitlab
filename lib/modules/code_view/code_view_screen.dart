import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'code_view_controller.dart';
import 'package:path/path.dart';

enum CodeViewScreenPopup { settings, share, branches }

class CodeViewScreen extends StatelessWidget {
  CodeViewScreen({Key? key}) : super(key: key);

  final controller = Get.find<CodeViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(BuildContext context) {
    // ignore: unused_local_variable
    var x = controller.refreshUI.value;

    var codetheme = "";
    codetheme = Get.isDarkMode ? AppCodeTheme.dark : AppCodeTheme.light;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              controller.file.value.fileName!,
            ),
            if (controller.path.value.isNotEmpty)
              Text(controller.path.value, style: const TextStyle(fontSize: 14)),
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry<CodeViewScreenPopup>>[
              PopupMenuItem(
                  value: CodeViewScreenPopup.branches,
                  child: Text('Switch branch'.tr)),
              PopupMenuItem(
                  value: CodeViewScreenPopup.share, child: Text('Share'.tr)),
              const PopupMenuDivider(),
              PopupMenuItem(
                  value: CodeViewScreenPopup.settings,
                  child: Text('View code options'.tr)),
            ],
            onSelected: (CodeViewScreenPopup value) =>
                controller.onPopupSelected(value, context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.retrieveFile(),
        child: HttpFutureBuilder(
          state: controller.state.value,
          child: InteractiveViewer(
            transformationController: controller.controller,
            constrained: false,
            child: SafeArea(
              bottom: false,
              child: AppHighlightView(
                content: controller.content.value,
                lang: extension(controller.file.value.filePath!)
                    .replaceAll(".", ""),
                fontSize:
                    //controller.fontSize.value,
                    controller.spStorage.getFontSize().value.toDouble(),
                lineNumbers: controller.spStorage.getShowLineNumbers().value,
                theme: codetheme,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
