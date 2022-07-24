import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/theme/theme.dart';

import 'create_issue.dart';

class CreateIssueScreen extends GetView<CreateIssueController> {
  const CreateIssueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add issue'.tr),
      ),
      body: SafeArea(child: _buildForm(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onSave();
        },
        child: const Icon(Icons.add),
        tooltip: 'Add'.tr,
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: controller.registerFormKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InputField(
                  labelText: "Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required.';
                    }
                    return null;
                  },
                  context: context,
                  controller: controller.titleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {},
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
            title: const Text('Assigned'),
            trailing: IconButton(
              onPressed: () {
                AppFocus.nextFocus(context);

                showSearch(context: context, delegate: UserSearch(controller));
              },
              icon: controller.assignee.value.id == null
                  ? const Icon(Icons.add)
                  : const Icon(Icons.search),
              tooltip:
                  controller.assignee.value.id == null ? 'Add'.tr : 'Change'.tr,
            ),
            subtitle: Wrap(
              spacing: 10,
              children: [
                if (controller.assignee.value.id != null &&
                    controller.assignee.value.id! > 0)
                  InputChip(
                    avatar: ListAvatar(
                        avatarUrl: controller.assignee.value.avatarUrl!),
                    label: Text(controller.assignee.value.name!),
                    deleteIcon: const Icon(Icons.remove_circle_outline,
                        color: Colors.red),
                    onDeleted: () {
                      controller.onAssigeeDeleted();
                    },
                  ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Milestone'),
            trailing: IconButton(
              onPressed: () {
                AppFocus.nextFocus(context);
                controller.onNavToMilestone();
              },
              icon: controller.milestone.value.id == null
                  ? const Icon(Icons.add)
                  : const Icon(Icons.search),
              tooltip: controller.milestone.value.id == null
                  ? 'Add'.tr
                  : 'Change'.tr,
            ),
            subtitle: Wrap(
              spacing: 10,
              children: [
                if (controller.milestone.value.id != null)
                  InputChip(
                    label: Text(controller.milestone.value.title!),
                    deleteIcon: const Icon(Icons.remove_circle_outline,
                        color: Colors.red),
                    onDeleted: () {
                      controller.onMilestoneDeleted();
                    },
                  ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Labels'),
            trailing: IconButton(
              onPressed: () {
                AppFocus.nextFocus(context);

                controller.onNavToLabels();
              },
              icon: const Icon(Icons.add),
              tooltip: 'Add',
            ),
            subtitle: Wrap(
              spacing: 10,
              children: [
                for (var item in controller.labels)
                  InputChip(
                    label: Text(item.name!,
                        style: TextStyle(
                            color: ThemeUtils.computeIluminance(
                                hexToColor(item.color!)))),
                    backgroundColor: hexToColor(item.color!),
                    deleteIcon: Icon(Icons.remove_circle_outline,
                        color: ThemeUtils.computeIluminance(
                            hexToColor(item.color!))),
                    onDeleted: () {
                      controller.onDeleteLabelAction(item);
                    },
                  ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class UserSearch extends SearchDelegate<String> {
  late final CreateIssueController controller;

  UserSearch(this.controller)
      : super(
          searchFieldStyle: const TextStyle(color: Colors.grey),
          searchFieldLabel: 'Search',
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
    controller.onUserSearchTextChanged(query);
    return _listWidget(context, controller);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.onUserSearchTextChanged(query);
    return _listWidget(context, controller);
  }
}

Widget _listWidget(BuildContext context, CreateIssueController controller) {
  return Obx(
    () => ListView.builder(
      controller: controller.scrollController,
      itemCount: controller.users.length,
      itemBuilder: (context, index) {
        var item = controller.users[index];

        return Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                child: CachedNetworkImage(
                  imageUrl: item.avatarUrl!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: imageProvider,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(item.name!),
              subtitle: Text(item.username!),
              onTap: () {
                controller.onUserSelected(item);
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
