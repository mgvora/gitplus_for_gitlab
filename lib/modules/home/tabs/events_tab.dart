import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/models/event.dart';
import 'package:gitplus_for_gitlab/modules/home/home.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityTab extends GetView<HomeController> {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _listWidget());
  }

  Widget _listWidget() {
    return RefreshIndicator(
      onRefresh: () => controller.listEvents(),
      child: HttpFutureBuilder(
        state: controller.eventsState.value,
        child: Scrollbar(
          controller: controller.eventsScrollController,
          child: ListView.builder(
              controller: controller.eventsScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: controller.events.length,
              itemBuilder: (context, index) {
                var item = controller.events[index];
                return _buildListItem(item);
              }),
        ),
      ),
    );
  }

  Widget _buildListItem(Event item) {
    return Column(
      children: [
        ListTile(
          contentPadding: CommonConstants.contentPaddingLitTileLarge,
          leading: ListAvatar(avatarUrl: item.author!.avatarUrl!),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: item.author!.name! + " ",
                    style: const TextStyle(
                        fontWeight: CommonConstants.fontWeightListTile)),
                TextSpan(
                    text: '@' + item.authorUsername!,
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventDescLabel.widget(item) ?? Container(),
              const SizedBox(height: 5),
              Text(timeago.format(item.createdAt!)),
            ],
          ),
          onTap: () {
            controller.onEventPressed(item);
          },
        ),
        const Divider(),
      ],
    );
  }
}
