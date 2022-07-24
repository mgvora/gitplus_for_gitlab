import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

import 'image_viewer_controller.dart';

class ImageViewerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageViewerController>(
        () => ImageViewerController(
              apiRepository: Get.find<ApiRepository>(),
              repository: Get.find<Repository>(),
            ),
        fenix: true);
  }
}
