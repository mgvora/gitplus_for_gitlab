import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class DateTimeField extends StatelessWidget {
  DateTimeField({
    Key? key,
    required this.labelText,
    this.controller,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  final String labelText;
  final TextEditingController? controller;
  final String? initialValue;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DateTimePicker(
        dateMask: 'yyyy-MM-dd',
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
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
        initialValue: initialValue,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: onChanged,
        validator: (val) {
          return null;
        },
        onSaved: (val) {},
      ),
    );
  }
}
