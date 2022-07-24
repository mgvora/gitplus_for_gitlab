import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import 'edit_project_label.dart';

class EditProjectLabelScreen extends GetView<EditProjectLabelController> {
  const EditProjectLabelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit label".tr),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => QuestionMessagePresetsDialog(
                  title: 'Delete label',
                  text: 'Are you sure?',
                  action: () async {
                    controller.onDeleteLabel();
                  },
                ),
              );
            },
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Delete label',
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onUpdateLabel();
        },
        child: const Icon(Icons.save_outlined),
        tooltip: 'Save'.tr,
      ),
      body: SafeArea(child: _buildForm(context)),
    );
  }

  Widget _buildForm(context) {
    return Form(
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
                        return 'Name is required.'.tr;
                      }
                      return null;
                    },
                    context: context,
                    controller: controller.editNameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.editNameChanged(value),
                  ),
                  MultilineInputField(
                      context: context,
                      labelText: "Description".tr,
                      controller: controller.editDescriptionController),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              title: Align(
                alignment: Alignment.topLeft,
                child: ColorLabel(
                  color: controller.editColor.string.isNotEmpty
                      ? hexToColor(controller.editColor.string)
                      : Colors.grey,
                  text: controller.editName.string,
                  padding: const EdgeInsets.only(
                      left: 10, top: 3, right: 10, bottom: 3),
                ),
              ),
              onTap: () {
                _showColorPicker(context);
              },
              trailing: IconButton(
                  onPressed: () {
                    _showColorPicker(context);
                  },
                  icon: const Icon(Icons.color_lens),
                  tooltip: 'Change color'.tr),
            ),
            const Divider(),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  _showColorPicker(context) {
    AppFocus.nextFocus(context);

    Color sc = Colors.red;
    if (controller.editColor.value.isNotEmpty) {
      sc = hexToColor(controller.editColor.value);
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Select a color'.tr),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Close'.tr))
              ],
              content: MaterialPicker(
                pickerColor: sc,
                onPrimaryChanged: (color) {},
                onColorChanged: (color) {
                  controller.onEditColorChanged(color);
                  Get.back();
                },
              ));
        });
  }
}
