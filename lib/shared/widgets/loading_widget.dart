import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Text(
          'Loading...',
          style: TextStyle(color: Get.theme.hintColor, fontSize: 18),
        ),
      ),
      ListView()
    ]);
  }
}
