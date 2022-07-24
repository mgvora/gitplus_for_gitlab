import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionMessagePresetsDialog extends StatelessWidget {
  final Function action;
  final String title;
  final String text;

  const QuestionMessagePresetsDialog({
    Key? key,
    required this.action,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text('Yes'),
          onPressed: () {
            action();
            Get.back();
          },
        ),
      ],
    );
  }
}
