import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'create_project_controller.dart';

class CreateProjectScreen extends GetView<CreateProjectController> {
  const CreateProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            controller.name.isEmpty ? 'New project' : controller.name.string),
      ),
      body: SafeArea(child: _buildForms(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onSubmit();
        },
        child: const Icon(Icons.add),
        tooltip: 'Create project',
      ),
    );
  }

  Widget _buildForms(context) {
    var vis = "";
    switch (controller.visibility.value) {
      case GitLabVisibility.private:
        vis = "Private";
        break;
      case GitLabVisibility.internal:
        vis = "Internal";
        break;
      case GitLabVisibility.public:
        vis = "Public";
        break;
    }

    return Form(
      key: controller.registerFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  InputField(
                    labelText: "Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required.';
                      }
                      return null;
                    },
                    autofocus: true,
                    context: context,
                    controller: controller.nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.nameChanged(value),
                  ),
                  MultilineInputField(
                      context: context,
                      labelText: "Description",
                      controller: controller.descriptionController),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.visibility),
              title: Text('Visibility'.tr),
              subtitle: Text(vis),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                AppFocus.nextFocus(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Visibility'.tr),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(),
                            ListTile(
                              selected: controller.visibility.value ==
                                  GitLabVisibility.private,
                              title: Text('Private'.tr),
                              onTap: () {
                                controller.onVisibilityChanged(
                                    GitLabVisibility.private);
                                Get.back();
                              },
                            ),
                            const Divider(),
                            ListTile(
                              selected: controller.visibility.value ==
                                  GitLabVisibility.internal,
                              title: Text('Internal'.tr),
                              onTap: () {
                                controller.onVisibilityChanged(
                                    GitLabVisibility.internal);
                                Get.back();
                              },
                            ),
                            const Divider(),
                            ListTile(
                              selected: controller.visibility.value ==
                                  GitLabVisibility.public,
                              title: Text('Public'.tr),
                              onTap: () {
                                controller.onVisibilityChanged(
                                    GitLabVisibility.public);
                                Get.back();
                              },
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('Cancel'.tr))
                      ],
                    );
                  },
                );
              },
            ),
            const Divider(),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
