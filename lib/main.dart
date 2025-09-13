import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_routes.dart';
import 'utils/app_localization.dart';
import 'utils/app_themes.dart';
import 'controllers/settings_controller.dart';
import 'controllers/auth_controller.dart';
import 'services/download_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await AppLocalization.init();
  await DownloadService.initNotifications();

  final SettingsController settingsController = Get.put(SettingsController());
  final AuthController authController = Get.put(AuthController());

  bool isDark = GetStorage().read('isDarkMode') ?? false;
  settingsController.isDarkMode.value = isDark;

  String langCode = GetStorage().read('languageCode') ?? 'en';
  String countryCode = GetStorage().read('countryCode') ?? 'US';
  settingsController.currentLocale.value = Locale(langCode, countryCode);
  Get.updateLocale(settingsController.currentLocale.value);

  runApp(MyApp(authController: authController));
}

class MyApp extends StatelessWidget {
  final AuthController authController;

  const MyApp({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (controller) {
        return Obx(
              () => GetMaterialApp(
            translations: AppLocalization(),
            locale: controller.currentLocale.value,
            fallbackLocale: const Locale('en', 'US'),
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode:
            controller.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,

            initialRoute: authController.token.value.isNotEmpty
                ? AppRoutes.articles
                : AppRoutes.login,

            getPages: AppRoutes.routes,
          ),
        );
      },
    );
  }
}
