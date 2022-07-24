import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: CrossFade<String>(
          initialData: '',
          data: 'Settings',
          builder: (value) => Text(value),
        ),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(context) {
    var code = "";
    code = Get.isDarkMode ? AppCodeTheme.dark : AppCodeTheme.light;
    // ignore: unused_local_variable
    var x = _controller.updateUI.value;

    return SafeArea(
      bottom: false,
      child: ListView(
        children: [
          _sectionHeader('General'),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Dark mode'),
            subtitle: Text(_controller.theme.value),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Dark mode'.tr),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Divider(),
                          ListTile(
                            selected: _controller.spStorage.getTheme().value ==
                                AppTheme.dark,
                            title: Text('On'.tr),
                            onTap: () {
                              _controller.changeThemeValue(AppTheme.dark);
                              Get.back();
                            },
                          ),
                          const Divider(),
                          ListTile(
                            selected: _controller.spStorage.getTheme().value ==
                                AppTheme.light,
                            title: Text('Off'.tr),
                            onTap: () {
                              _controller.changeThemeValue(AppTheme.light);
                              Get.back();
                            },
                          ),
                          const Divider(),
                          ListTile(
                            selected: _controller.spStorage.getTheme().value ==
                                AppTheme.system,
                            title: Text('System'.tr),
                            onTap: () {
                              _controller.changeThemeValue(AppTheme.system);
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
          _sectionHeader('Code'),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.format_list_numbered),
            title: const Text('Show line numbers'),
            trailing: AppSwitch(
                value: _controller.spStorage.getShowLineNumbers().value,
                onChanged: (value) {
                  _controller.onShowLineNumbersChanged(value);
                }),
          ),
          const Divider(),
          _fontSize(),
          const Divider(),
          SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AppHighlightView(
                content: '''#include <iostream>
using namespace std;

int main() {
  // This is a comment
  cout << "Hello World!";
  return 0;
}''',
                lang: 'cpp',
                fontSize: _controller.fontSize.value,
                theme: code,
                lineNumbers: _controller.spStorage.getShowLineNumbers().value,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('Reset defaults'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => QuestionMessagePresetsDialog(
                  title: 'Reset settings'.tr,
                  text: 'This will reset your settings. No data will be deleted'
                      .tr,
                  action: () async {
                    await _controller.onResetDefault();
                  },
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _fontSize() {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, top: 15, bottom: 5, right: 15),
          child: Row(
            children: [
              const Text('Font size', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 5),
              Text(_controller.fontSize.value.toInt().toString(),
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
        Slider(
          value: _controller.fontSize.value,
          onChangeEnd: (value) {
            _controller.onFontSizeChangedEnd(value);
          },
          onChanged: (value) {
            _controller.onFontSizeChanged(value);
          },
          min: 8,
          max: 30,
          // divisions: 45,
        ),
      ],
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
