import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final storage = GetStorage();

  var currentLocale = const Locale('en', 'US').obs;

  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Load saved theme
    isDarkMode.value = storage.read('isDarkMode') ?? Get.isDarkMode;

    // Load saved language
    String langCode = storage.read('languageCode') ?? 'en';
    String countryCode = storage.read('countryCode') ?? 'US';
    currentLocale.value = Locale(langCode, countryCode);
    Get.updateLocale(currentLocale.value);
  }

  /// Change app language
  void changeLanguage(String languageCode) {
    if (languageCode == 'en') {
      currentLocale.value = const Locale('en', 'US');
    } else if (languageCode == 'bn') {
      currentLocale.value = const Locale('bn', 'BD');
    }

    // Update locale in GetX
    Get.updateLocale(currentLocale.value);

    // Save selection
    storage.write('languageCode', currentLocale.value.languageCode);
    storage.write('countryCode', currentLocale.value.countryCode);
  }

  /// Change app theme
  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);

    // Save selection theme mode
    storage.write('isDarkMode', value);
  }
}
