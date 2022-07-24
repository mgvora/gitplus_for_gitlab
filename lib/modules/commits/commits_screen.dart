import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';

import 'commits.dart';

class CommitsScreen extends GetView<CommitsController> {
  const CommitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget());
  }

  Widget _buildWidget() {
    // ignore: unused_local_variable
    var l = controller.commits.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Commits".tr),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      onRefresh: () => controller.listCommits(),
      child: HttpFutureBuilder(
        state: controller.state.value,
        child: Scrollbar(
          controller: controller.scrollControllerCommits,
          child: GroupedListView<Commit, DateTime>(
              // ignore: invalid_use_of_protected_member
              elements: controller.commits.value,
              controller: controller.scrollControllerCommits,
              physics: const AlwaysScrollableScrollPhysics(),
              order: GroupedListOrder.DESC,
              groupBy: (Commit element) => DateTime(
                    element.createdAt!.year,
                    element.createdAt!.month,
                    element.createdAt!.day,
                  ),
              groupSeparatorBuilder: (DateTime element) =>
                  _buildGroupSeparator(element),
              itemComparator: (element1, element2) =>
                  element1.createdAt!.compareTo(element2.createdAt!),
              itemBuilder: (context, element) {
                return _buildListItem(element, context);
              }),
        ),
      ),
    );
  }

  Widget _buildListItem(Commit item, BuildContext context) {
    return Column(
      children: [
        ListTile(
          // contentPadding: CommonConstants.contentPaddingLitTileLarge,
          title: Text(
            item.title!,
            style:
                const TextStyle(fontWeight: CommonConstants.fontWeightListTile),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              // Text(item.shortId!),
              // const SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: item.authorName! + " ",
                        style: const TextStyle(
                            fontWeight: CommonConstants.fontWeightListTile)),
                    TextSpan(
                        text: "authored " + timeago.format(item.createdAt!),
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            controller.onCommitSelected(item);
          },
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildGroupSeparator(DateTime element) {
    final String formatted = DateFormat('dd MMMM, yyyy').format(element);

    return Column(
      children: [
        ListTile(
            title: Text(
          formatted.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )),
        const Divider(),
      ],
    );
  }
}
