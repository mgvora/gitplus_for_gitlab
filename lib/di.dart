import 'package:get/get.dart';
import 'package:gitplus_for_gitlab/shared/data/data.dart';

class DenpendencyInjection {
  static Future<void> init() async {
    Get.put(SecureStorage(), permanent: true);
    await Get.find<SecureStorage>().init();

    Get.put(SPStorage(), permanent: true);
    await Get.find<SPStorage>().init();
  }
}
