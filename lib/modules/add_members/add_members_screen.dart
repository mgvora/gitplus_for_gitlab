import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'add_members.dart';

class AccessLevelItem {
  final String name;
  final int value;

  AccessLevelItem({
    required this.name,
    required this.value,
  });
}

class AddMembersScreen extends GetView<AddMembersController> {
  const AddMembersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add members"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(controller));
            },
            tooltip: 'Search',
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15), child: _formWidget(context)),
      floatingActionButton: AbsorbPointer(
        absorbing: controller.addedUsers.isEmpty,
        child: FloatingActionButton(
          onPressed: () {
            controller.onSubmit();
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _formWidget(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Members:'),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(5)),
            height: 200,
            child: controller.addedUsers.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.addedUsers.length,
                    itemBuilder: (context, index) {
                      var item = controller.addedUsers[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Text(item.name!),
                            leading: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: item.avatarUrl!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: imageProvider,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                controller.onItemRemove(item);
                              },
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.red),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    })
                : const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Tapping on the "search button" icon will open up search box, where you can find members. You can add one or more members here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )),
                  ),
          ),
          const SizedBox(height: 15),
          const Divider(),
          ListTile(
              title: const Text('Access level'),
              trailing: DropdownButton<AccessLevelItem>(
                  items: controller.accessLevels.map((e) {
                    return DropdownMenuItem<AccessLevelItem>(
                        value: e, child: Text(e.name));
                  }).toList(),
                  value: controller.selectedAccessLevel.value,
                  onChanged: (value) {
                    controller.onAccessLevelChanged(value);
                  })),
          const Divider(),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  late final AddMembersController controller;

  DataSearch(this.controller)
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
    controller.onSearchTextChanged(query);
    return _listWidget(context, controller);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.onSearchTextChanged(query);
    return _listWidget(context, controller);
  }
}

Widget _listWidget(BuildContext context, AddMembersController controller) {
  return Obx(
    () => HttpFutureBuilder(
        state: controller.state.value,
        child: ListView.builder(
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
                      controller.onItemAdd(item);
                      Get.back();
                    },
                  ),
                  const Divider(),
                ],
              );
            })),
  );
}
