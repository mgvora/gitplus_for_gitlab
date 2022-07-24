import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import 'issue_related_merge_requests.dart';

class IssueRelatedMergeRequestsScreen
    extends GetView<IssueRelatedMergeRequestsController> {
  const IssueRelatedMergeRequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var len = controller.requests.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Related merge requests'),
      ),
      body: _list(),
    );
  }

  Widget _list() {
    return RefreshIndicator(
      onRefresh: () => controller.listRequests(1),
      child: ListView.builder(
        controller: controller.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.requests.length,
        itemBuilder: (context, index) {
          var item = controller.requests[index];
          return _buildListItem(item);
        },
      ),
    );
  }

  // Widget _buildListTile(MergeRequest item) {
  //   Widget? state;

  //   if (item.state == MergeRequestState.opened) {
  //     state = Icon(Octicons.issue_opened, color: Colors.green);
  //   } else if (item.state == MergeRequestState.closed) {
  //     state = Icon(Icons.remove_circle_outline, color: Colors.red);
  //   } else if (item.state == MergeRequestState.locked) {
  //     state = Icon(Octicons.lock);
  //   } else {
  //     state = Icon(Octicons.git_merge);
  //   }

  //   Widget? milestone;

  //   if (item.milestone != null) {
  //     milestone = Row(
  //       children: [
  //         Icon(Icons.access_time, size: 16),
  //         SizedBox(width: 3),
  //         Text(item.milestone!.title!, style: TextStyle(fontSize: 12)),
  //       ],
  //     );
  //   }

  //   return Column(
  //     children: [
  //       ListTile(
  //         contentPadding: CommonConstants.contentPaddingLitTileLarge,
  //         leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
  //         title: Text(item.author!.name!),
  //         subtitle: Column(
  //           crossAxisAlignment: CrossAxisAlignment.stretch,
  //           children: [
  //             Text(item.title! + ' !' + item.iid.toString()),
  //             SizedBox(height: 5),
  //             milestone ?? Container(),
  //           ],
  //         ),
  //         trailing: state,
  //       ),
  //       Divider(),
  //     ],
  //   );
  // }

  Widget _buildListItem(MergeRequest item) {
    return Column(
      children: [
        ListTile(
          contentPadding: CommonConstants.contentPaddingLitTileLarge,
          leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
          title: Text(
            item.title!,
            style:
                const TextStyle(fontWeight: CommonConstants.fontWeightListTile),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: item.author!.name! + " ",
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
            controller.onSelected(item);
          },
        ),
        const Divider(),
      ],
    );
  }
}
