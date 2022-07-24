import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'accounts.dart';

class AccountDetailsScreen extends StatelessWidget {
  AccountDetailsScreen({Key? key}) : super(key: key);

  final controller = Get.find<AccountsController>();

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.account.value.username!)),
      body: _details(context),
    );
  }

  Widget _details(context) {
    var m = controller.account.value;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    ListAvatar(avatarUrl: m.avatarUrl!),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.name!, style: const TextStyle(fontSize: 18)),
                        Text(m.username!),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Server: '),
                    Text(m.baseUrl!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    if (m.userId != controller.defaultId.value)
                      XElevatedButton(
                        child: const Text('Set as default'),
                        onPressed: () {
                          controller.onSetDefault(controller.account.value);
                          Get.back();
                        },
                      ),
                    if (m.userId != controller.defaultId.value)
                      const SizedBox(width: 10),
                    XElevatedButton(
                      child: const Text('Remove'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => QuestionMessagePresetsDialog(
                            title: 'Delete account',
                            text: 'Are you sure?',
                            action: () async {
                              await controller.onRemoveAccount();
                              Get.back();
                            },
                          ),
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
