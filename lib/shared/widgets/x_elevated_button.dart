import 'package:flutter/material.dart';

class XElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const XElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          // overlayColor: MaterialStateProperty.all(backgroundColor),
          // shadowColor: MaterialStateProperty.all(backgroundColor),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          foregroundColor: MaterialStateProperty.all(foregroundColor),
          padding: MaterialStateProperty.resolveWith(
            (states) {
              return const EdgeInsets.symmetric(horizontal: 10, vertical: 12);
            },
          ),
        ),
        onPressed: () => onPressed(),
        child: child);
  }
}
