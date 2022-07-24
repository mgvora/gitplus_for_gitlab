import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'issue_notes.dart';

class IssueNotesScreen extends GetView<IssueNotesController> {
  const IssueNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var len = controller.notes.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'.tr),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: _list()),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    autocorrect: false,
                    controller: controller.bodyController,
                    decoration: const InputDecoration(
                      labelText: "Comment",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      labelStyle: TextStyle(),
                      fillColor: Colors.blue,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide(color: Colors.purpleAccent)),
                    ),
                  ),
                ),
                // Second child is button
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    controller.onCreateNew();
                  },
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list() {
    return RefreshIndicator(
      onRefresh: () => controller.listNotes(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: controller.scrollController,
          child: ListView.builder(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.notes.length,
            itemBuilder: (context, index) {
              var item = controller.notes[index];
              return Column(
                children: [
                  ListTile(
                    contentPadding: CommonConstants.contentPaddingLitTileLarge,
                    leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
                    title: Text(item.body!),
                    subtitle: Text(item.author!.name! +
                        " authored " +
                        timeago.format(item.createdAt!)),
                    trailing: !item.system!
                        ? IconButton(
                            onPressed: () {
                              controller.onNavToEdit(item);
                            },
                            icon: const Icon(Icons.edit))
                        : null,
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
