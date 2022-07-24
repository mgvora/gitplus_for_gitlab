import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/branches/branches.dart';
import 'package:gitplus_for_gitlab/routes/routes.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io' as io;

import 'code_view_screen.dart';

class CodeViewController extends GetxController with HttpController {
  final ApiRepository apiRepository;
  final Repository repository;

  CodeViewController({
    required this.apiRepository,
    required this.repository,
  });

  final spStorage = Get.find<SPStorage>();

  final controller = TransformationController();

  var refreshUI = 0.obs;

  var file = File().obs;
  var content = "".obs;
  var path = "".obs;

  late StreamSubscription _branchSubscription;
  late StreamSubscription _updateSubscription;

  Timer? _updateTimer;

  var fontSize = 20.0.obs;
  var baseFontSize = 20.0.obs;
  var fontScale = 1.0.obs;
  var baseFontScale = 1.0.obs;

  @override
  void onReady() async {
    super.onReady();
    retrieveFile();

    _updateSubscription = spStorage.getTheme().listen((p0) {
      if (_updateTimer != null && _updateTimer!.isActive) return;
      _updateTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
        refreshUI.value++;
        timer.cancel();
      });
    });

    _branchSubscription = repository.ref.listen((p0) {
      retrieveFile();
    });
  }

  @override
  void onClose() {
    _branchSubscription.cancel();
    _updateSubscription.cancel();
    _updateTimer?.cancel();
    super.onClose();
  }

  Future<void> retrieveFile() async {
    state.value = HttpState.loading;
    await runWithErrorHandlingWithoutState(() async {
      file.value = await apiRepository.getFile(
              repository.project.value.id ?? -1,
              repository.filePath.value,
              FileRequest(ref: repository.ref.value)) ??
          File();
      path.value = file.value.filePath!.split('/').last;
      path.value = file.value.filePath!.replaceAll(path.value, '');
      if (path.value.isNotEmpty) {
        path.value = path.value.substring(0, path.value.length - 1);
      }
      try {
        content.value = utf8.decode(base64.decode(file.value.content ?? ""));
      } catch (e) {
        CommonWidget.toast('Cannot decode this file!');
      }
    }).then((value) => handleHttpActionState(value));
  }

  onPopupSelected(CodeViewScreenPopup value, BuildContext context) async {
    switch (value) {
      case CodeViewScreenPopup.settings:
        Get.toNamed(Routes.settings);
        break;
      case CodeViewScreenPopup.share:
        try {
          var directory = await getApplicationDocumentsDirectory();
          var f = io.File('${directory.path}/${file.value.fileName}');
          await f.writeAsString(content.value);
          Share.shareFiles([f.path]);
        } catch (e) {
          CommonWidget.toast('Something went wrong!');
        }
        break;
      case CodeViewScreenPopup.branches:
        Get.toNamed(
          Routes.branches,
          arguments: BranchesScreenArgs(
            onRefSelected: (value) {
              repository.ref.value = value;
            },
            selectedRef: repository.ref.value,
            returnRoute: Get.currentRoute,
          ),
        );
        break;
    }
  }
}
