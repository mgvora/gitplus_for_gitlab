import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/models/types.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'edit_project.dart';

class EditProjectScreen extends GetView<EditProjectController> {
  const EditProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit project'.tr),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  InputField(
                    labelText: "Name".tr,
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
                    labelText: "Path".tr,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'this field is required.'.tr;
                      }
                      return null;
                    },
                    context: context,
                    controller: controller.pathController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {},
                  ),
                  MultilineInputField(
                    labelText: "Description".tr,
                    context: context,
                    controller: controller.descriptionController,
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
            ListTile(
              contentPadding: CommonConstants.contentPaddingLitTileLarge,
              title: Text('Default branch'.tr),
              onTap: () {
                showSearch(
                    context: context, delegate: BranchSearch(controller));
              },
              trailing: IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: BranchSearch(controller));
                },
                icon: controller.branch.value.isEmpty
                    ? const Icon(Icons.add)
                    : const Icon(Icons.search),
                tooltip:
                    controller.branch.value.isEmpty ? 'Add'.tr : 'Change'.tr,
              ),
              subtitle: Wrap(
                spacing: 10,
                children: [
                  if (controller.branch.value.isNotEmpty)
                    Chip(label: Text(controller.branch.value)),
                ],
              ),
            ),
            const Divider(),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}

class BranchSearch extends SearchDelegate<String> {
  late final EditProjectController controller;

  BranchSearch(this.controller)
      : super(
          searchFieldStyle: const TextStyle(color: Colors.grey),
          searchFieldLabel: 'Search branch'.tr,
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: searchLeadingIcon());
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.onBranchSearchTextChanged(query);
    return _branchesListWidget(context, controller);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.onBranchSearchTextChanged(query);
    return _branchesListWidget(context, controller);
  }
}

Widget _branchesListWidget(
    BuildContext context, EditProjectController controller) {
  return Obx(
    () => ListView.builder(
      controller: controller.branchesScrollController,
      itemCount: controller.branches.length,
      itemBuilder: (context, index) {
        var item = controller.branches[index];

        return Column(
          children: [
            ListTile(
              title: Text(item.name!),
              onTap: () {
                controller.onBranchSelected(item);
                Get.back();
              },
            ),
            const Divider(),
          ],
        );
      },
    ),
  );
}
