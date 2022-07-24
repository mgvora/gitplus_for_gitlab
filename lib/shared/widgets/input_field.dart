import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.context,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onEditingComplete,
    this.obscureText,
    this.autofocus = false,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly,
    this.autofillHints,
  }) : super(key: key);

  final BuildContext context;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? readOnly;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        readOnly: readOnly ?? false,
        validator: validator,
        autofocus: autofocus,
        autofillHints: autofillHints,
        controller: controller,
        keyboardType: keyboardType,
        onEditingComplete: onEditingComplete,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        onTap: onTap,
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
