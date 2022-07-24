import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/models/types.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'edit_project_snippet.dart';

class EditProjectSnippetScreen extends GetView<EditProjectSnippetController> {
  const EditProjectSnippetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit snippet'.tr),
      ),
      body: SafeArea(child: _buildForm(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.save();
        },
        child: const Icon(Icons.save),
        tooltip: 'Save'.tr,
      ),
    );
  }

  Widget _buildForm(context) {
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
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InputField(
                  labelText: "Title".tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required.'.tr;
                    }
                    return null;
                  },
                  context: context,
                  controller: controller.titleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {},
                ),
                InputField(
                  labelText: "Filename".tr,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'this field is required.'.tr;
                    }
                    return null;
                  },
                  context: context,
                  controller: controller.filenameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {},
                ),
                MultilineInputField(
                  context: context,
                  labelText: "Code".tr,
                  controller: controller.codeController,
                ),
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
                              controller
                                  .onVisibilityChanged(GitLabVisibility.public);
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
    );
  }
}
