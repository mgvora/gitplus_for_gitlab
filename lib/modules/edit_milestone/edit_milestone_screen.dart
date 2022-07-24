import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'edit_milestone.dart';

class EditMilestoneScreen extends GetView<EditMilestoneController> {
  const EditMilestoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildWidget(context));
  }

  Widget _buildWidget(context) {
    // ignore: unused_local_variable
    var x = controller.dueDateInitVal.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit milestone'.tr),
      ),
      body: SafeArea(child: _buildForm(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateProjectMilestone();
        },
        child: const Icon(Icons.save),
        tooltip: 'Save'.tr,
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: controller.registerFormKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              InputField(
                labelText: "Title".tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'this field is required.'.tr;
                  }
                  return null;
                },
                context: context,
                controller: controller.titleController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onChanged: (value) {},
              ),
              DateTimeField(
                controller: controller.dueDateController,
                labelText: 'Due date'.tr,
              ),
              MultilineInputField(
                  context: context,
                  labelText: "Description".tr,
                  controller: controller.descriptionController),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
