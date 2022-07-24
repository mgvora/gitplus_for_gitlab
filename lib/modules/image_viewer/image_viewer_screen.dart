import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/modules/image_viewer/image_viewer.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';

class ImageViewerScreen extends GetView<ImageViewerController> {
  const ImageViewerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text(controller.file.value.fileName!)),
        body: HttpFutureBuilder(
          state: controller.state.value,
          child: SafeArea(child: controller.widget),
        ),
      ),
    );
  }
}
