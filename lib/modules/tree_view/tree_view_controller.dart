import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import 'tree_view_screen.dart';

class TreeViewController extends GetxController with HttpController {
  final ApiRepository apiRepository;
  final Repository repository;

  TreeViewController({
    required this.apiRepository,
    required this.repository,
  });

  final _storage = Get.find<SPStorage>();

  @override
  void onReady() {
    super.onReady();
  }

  void onItemSelected(Tree item) {
    if (item.type == TreeTypes.blob) {
      var ext = extension(item.path ?? '').replaceAll(".", "");

      repository.filePath.value = item.path ?? "";

      switch (ext) {
        case 'md':
          Get.toNamed(Routes.mdView);
          break;
        case 'png':
          Get.toNamed(Routes.imageViewer);
          break;
        case 'jpg':
          Get.toNamed(Routes.imageViewer);
          break;
        case 'jpeg':
          Get.toNamed(Routes.imageViewer);
          break;
        case 'gif':
          Get.toNamed(Routes.imageViewer);
          break;
        case 'webp':
          Get.toNamed(Routes.imageViewer);
          break;
        case 'svg':
          Get.toNamed(Routes.imageViewer);
          break;
        default:
          Get.toNamed(Routes.codeView);
      }
    } else {
      Get.toNamed(Routes.treeViewRoot,
          arguments: TreeViewArgs(path: item.path ?? "", name: item.name ?? ""),
          preventDuplicates: false);
    }
  }
}
