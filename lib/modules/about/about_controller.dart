import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutController extends GetxController {
  late PackageInfo _packageInfo;

  var version = "".obs;

  @override
  void onInit() async {
    super.onInit();
    _packageInfo = await PackageInfo.fromPlatform();
    version.value = _packageInfo.version;
  }
}
