import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/modules/commit/commit_screen.dart';
import 'package:gitplus_for_gitlab/modules/tree_view/tree_view.dart';
import 'package:gitplus_for_gitlab/routes/app_pages.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CommitController extends GetxController
    with HttpController, PagingController {
  final ApiRepository apiRepository;
  final Repository repository;

  CommitController({
    required this.apiRepository,
    required this.repository,
  });

  final spStorage = Get.find<SPStorage>();

  late ScrollController scrollController = ScrollController()
    ..addListener(_scrollListener);

  late PagingResponse<Diff> _diffRes;

  var diff = <Diff>[].obs;

  var _page = 0;

  late StreamSubscription _themeSubscription;
  late StreamSubscription _fontSizeSubscription;

  Timer? _themeTimer;
  Timer? _fontsizeTimer;

  var refreshUI = 0.obs;

  @override
  void onReady() async {
    super.onReady();

    getDiff();

    _themeSubscription = spStorage.getTheme().listen((p0) {
      if (_themeTimer != null && _themeTimer!.isActive) return;
      _themeTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
        refreshUI.value++;
        timer.cancel();
      });
    });

    _fontSizeSubscription = spStorage.getFontSize().listen((p0) {
      if (_fontsizeTimer != null && _fontsizeTimer!.isActive) return;
      _fontsizeTimer =
          Timer.periodic(const Duration(milliseconds: 300), (timer) {
        refreshUI.value++;
        timer.cancel();
      });
    });
  }

  @override
  void onClose() {
    _themeSubscription.cancel();
    _fontSizeSubscription.cancel();
    scrollController.dispose();
    _themeTimer?.cancel();
    _fontsizeTimer?.cancel();
    super.onClose();
  }

  Future<void> getDiff() async {
    await runWithErrorHandling(() async {
      _diffRes = await apiRepository.getDiff(repository.project.value.id!,
              repository.commit.value.id!, DiffRequest()) ??
          PagingResponse<Diff>();
      diff.value = initPagingList(_diffRes);
    });
  }

  Future<void> getDiffMore(int page) async {
    _page = page;
    await runWithErrorHandlingWithoutState(() async {
      _diffRes = await apiRepository.getDiff(repository.project.value.id!,
              repository.commit.value.id!, DiffRequest(page: page)) ??
          PagingResponse<Diff>();
      if (page == 1) {
        diff.value = initPagingList(_diffRes);
      } else {
        diff.addAll(initPagingList(_diffRes));
      }
    });
  }

  Future<void> _scrollListener() async {
    scrollListener(
        scrollController, _diffRes, (value) => getDiffMore(value), _page);
  }

  onPopupSelected(CommitScreenPopupActions value) {
    switch (value) {
      case CommitScreenPopupActions.browseFiles:
        repository.ref.value = repository.commit.value.id!;
        Get.toNamed(Routes.treeViewRoot,
            arguments: TreeViewArgs(
                name: repository.commit.value.shortId ?? "", path: ""));
        break;
      case CommitScreenPopupActions.openWeb:
        launch(repository.commit.value.webUrl!);
        break;
      case CommitScreenPopupActions.share:
        Share.share(repository.commit.value.webUrl!);
        break;
      case CommitScreenPopupActions.settings:
        Get.toNamed(Routes.settings);
        break;
    }
  }

  void onFileSelected(Diff item) {
    repository.ref.value = repository.commit.value.id!;
    repository.filePath.value = item.newPath!;
    Get.toNamed(Routes.codeView);
  }
}
