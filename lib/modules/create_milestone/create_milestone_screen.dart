import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'package:get/get.dart';

import 'create_milestone.dart';

class CreateMilestoneScreen extends GetView<CreateMilestoneController> {
  const CreateMilestoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add milestone'.tr),
      ),
      body: SafeArea(bottom: false, child: _buildForm(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addProjectMilestone();
        },
        child: const Icon(Icons.add),
        tooltip: 'Add'.tr,
      ),
    );
  }

  Widget _buildForm(context) {
    return Form(
      key: controller.registerFormKey,
      child: ListView(
        children: [
          Padding(
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
        ],
      ),
    );
  }
}
