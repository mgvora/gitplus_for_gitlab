import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class ImageViewerController extends GetxController with HttpController {
  final ApiRepository apiRepository;
  final Repository repository;

  ImageViewerController({
    required this.apiRepository,
    required this.repository,
  });

  @override
  void onReady() async {
    super.onReady();
    getImage();
  }

  var file = File().obs;
  var bytes = <int>[].obs;
  Widget widget = Container();

  Future<void> getImage() async {
    await runWithErrorHandling(() async {
      file.value = await apiRepository.getFile(
              repository.project.value.id ?? -1,
              repository.filePath.value,
              FileRequest(ref: repository.ref.value)) ??
          File();

      if (file.value.fileName!.contains('svg')) {
        try {
          var content = utf8.decode(base64.decode(file.value.content ?? ""));
          widget = SvgPicture.string(content);
        } catch (e) {
          CommonWidget.toast(CommonConstants.errorMessage);
        }
      } else {
        try {
          widget = Image.memory(base64.decode(file.value.content!));
        } catch (e) {
          CommonWidget.toast(CommonConstants.errorMessage);
        }
      }
    });
  }
}
