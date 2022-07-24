import 'package:flutter/material.dart';

class MultilineInputField extends StatelessWidget {
  const MultilineInputField({
    Key? key,
    required this.context,
    required this.labelText,
    this.controller,
    this.autofocus = false,
  }) : super(key: key);

  final BuildContext context;
  final String labelText;
  final TextEditingController? controller;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        minLines: 5,
        maxLines: 100,
        autofocus: autofocus,
        controller: controller,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: labelText,
          // labelStyle: TextStyle(color: Colors.grey[700]),
          errorStyle: const TextStyle(color: Colors.red),
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
    );
  }
}
