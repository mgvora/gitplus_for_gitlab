import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import 'create_project_label.dart';

class CreateProjectLabelScreen extends GetView<CreateProjectLabelController> {
  const CreateProjectLabelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New label".tr),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.onAddLabel();
        },
        child: const Icon(Icons.add),
        tooltip: 'Add'.tr,
      ),
      body: SafeArea(child: _buildForm(context)),
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: controller.addLabelFormKey,
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
                    controller: controller.nameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => controller.addNameChanged(value),
                  ),
                  MultilineInputField(
                      context: context,
                      labelText: "Description".tr,
                      controller: controller.descriptionController),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                _showColorPicker(context);
              },
              title: Align(
                alignment: Alignment.topLeft,
                child: ColorLabel(
                  color: controller.addColor.string.isNotEmpty
                      ? hexToColor(controller.addColor.string)
                      : Colors.grey.shade300,
                  text: controller.addName.string,
                  padding: const EdgeInsets.only(
                      left: 10, top: 3, right: 10, bottom: 3),
                ),
              ),
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
    if (controller.addColor.value.isNotEmpty) {
      sc = hexToColor(controller.addColor.value);
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
                  controller.onAddColorChanged(color);
                  Get.back();
                },
              ));
        });
  }
}
