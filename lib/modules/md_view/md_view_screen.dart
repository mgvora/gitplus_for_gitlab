import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/modules/branches/branches.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'md_view.dart';

class MdViewScreen extends StatelessWidget {
  MdViewScreen({Key? key}) : super(key: key);

  final controller = Get.find<MdViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.file.value.fileName ?? ""),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                Routes.branches,
                arguments: BranchesScreenArgs(
                  onRefSelected: (value) {
                    controller.repository.ref.value = value;
                  },
                  selectedRef: controller.repository.ref.value,
                  returnRoute: Get.currentRoute,
                ),
              );
            },
            icon: const Icon(Octicons.git_branch),
            tooltip: 'Change branch'.tr,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.retrieveFile(),
        child: ListView(
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: AppMarkdown(content: controller.content.string),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
