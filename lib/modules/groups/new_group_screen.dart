import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

import 'groups_controller.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({Key? key}) : super(key: key);

  @override
  _NewGroupScreenState createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen>
    with SingleTickerProviderStateMixin {
  final GroupsController _controller = Get.arguments;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New group'),
      ),
      body: _buildForms(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.onAddGroup();
        },
        child: const Icon(Icons.add),
        tooltip: 'Create group',
      ),
    );
  }

  Widget _buildForms(context) {
    return Form(
      key: _controller.registerFormKey,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InputField(
                  labelText: "Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required.';
                    }
                    return null;
                  },
                  autofocus: true,
                  context: context,
                  controller: _controller.nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                InputField(
                    labelText: "Path",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Path is required.';
                      }
                      return null;
                    },
                    context: context,
                    controller: _controller.pathController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next),
                MultilineInputField(
                    context: context,
                    labelText: "Description",
                    controller: _controller.descriptionController),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
