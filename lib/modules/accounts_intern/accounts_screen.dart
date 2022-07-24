import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'accounts.dart';

class AccountsScreen extends GetView<AccountsController> {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    var x = controller.defaultId.value;
    // ignore: invalid_use_of_protected_member
    var xx = controller.accounts.value;
    var xxx = controller.account.value;
    return Scaffold(
      appBar: AppBar(
        title: CrossFade<String>(
          initialData: '',
          data: 'Accounts',
          builder: (value) => Text(value),
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.onAddClicked();
              },
              icon: const Icon(Icons.add),
              tooltip: 'Add account'.tr),
        ],
      ),
      body: _listAccounts(context),
    );
  }

  Widget _listAccounts(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.accounts.length,
        itemBuilder: (context, index) {
          var item = controller.accounts[index];

          return Column(
            children: [
              ListTile(
                // contentPadding:
                //     const EdgeInsets.only(left: 15, top: 10, bottom: 10),
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
                title: Text(item.username!,
                    style: const TextStyle(
                        fontWeight: CommonConstants.fontWeightListTile)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.baseUrl!),
                  ],
                ),
                trailing: item.userId == controller.defaultId.value
                    ? Icon(Icons.done, color: Get.theme.colorScheme.secondary)
                    : null,
                onTap: () {
                  controller.onAccountSelected(item);
                },
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
