import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HttpTokenExpiredWidget extends StatelessWidget {
  const HttpTokenExpiredWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: Text(
          'Your access token is expired',
          style: TextStyle(color: Get.theme.hintColor, fontSize: 18),
        ),
      ),
      ListView()
    ]);
  }
}
