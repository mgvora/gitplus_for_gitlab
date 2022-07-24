import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gitplus_for_gitlab/shared/shared.dart';
import 'package:get/get.dart';

import 'app_binding.dart';
import 'di.dart';
import 'lang/lang.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

bool auth = false;
bool futureInitilized = false;
bool initilized = false;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Init._().initialize();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  runApp(const App());

  configLoading();
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !initilized) {
          initilized = true;
          return MaterialApp(home: Container());
        } else {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            enableLog: false,
            initialRoute: auth ? Routes.auth : Routes.home,
            getPages: AppPages.routes,
            initialBinding: AppBinding(),
            smartManagement: SmartManagement.keepFactory,
            theme: ThemeConfig.lightTheme,
            darkTheme: ThemeConfig.darkTheme,
            locale: TranslationService.locale,
            fallbackLocale: TranslationService.fallbackLocale,
            translations: TranslationService(),
            builder: EasyLoading.init(),
          );
        }
      },
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    if (futureInitilized) {
      return;
    }
    futureInitilized = true;
    await DenpendencyInjection.init();

    auth = Get.find<SecureStorage>().getToken().isEmpty;
    var theme = Get.find<SPStorage>().getTheme();

    if (theme.value == AppTheme.light) {
      Get.changeThemeMode(ThemeMode.light);
    } else if (theme.value == AppTheme.dark) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.system);
    }
    FlutterNativeSplash.remove();
  }
}

void configLoading() {
  EasyLoading.instance
    ..toastPosition = EasyLoadingToastPosition.top
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 30.0
    ..radius = 10.0
    // ..progressColor = Colors.yellow
    ..backgroundColor = Colors.grey.shade300
    ..indicatorColor = Colors.grey.shade800
    ..textColor = hexToColor('#64DEE0')
    // ..maskColor = Colors.red
    ..userInteractions = true
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
