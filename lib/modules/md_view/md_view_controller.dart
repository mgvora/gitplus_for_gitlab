import 'dart:async';
import 'dart:convert';

import 'package:gitplus_for_gitlab/api/api.dart';
import 'package:gitplus_for_gitlab/models/models.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

class MdViewController extends GetxController {
  final ApiRepository apiRepository;
  final Repository repository;

  MdViewController({
    required this.apiRepository,
    required this.repository,
  });

  var file = File().obs;
  var content = "".obs;

  late StreamSubscription _refSubscription;

  @override
  void onReady() async {
    super.onReady();
    retrieveFile();

    _refSubscription = repository.ref.listen((p0) {
      retrieveFile();
    });
  }

  @override
  void onClose() {
    file.close();
    content.close();
    _refSubscription.cancel();
    super.onClose();
  }

  Future<void> retrieveFile() async {
    file.value = await apiRepository.getFile(
            repository.project.value.id ?? -1,
            repository.filePath.value,
            FileRequest(ref: repository.ref.value)) ??
        File();

    content.value = utf8.decode(base64.decode(file.value.content ?? ""));
  }
}
