import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../controllers/auth_controller.dart';

class SettingsView extends StatelessWidget {
  final SettingsController controller = Get.find<SettingsController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("settings".tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("language".tr,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Language Dropdown
            Obx(() => DropdownButton<String>(
              value: controller.currentLocale.value.languageCode,
              items: const [
                DropdownMenuItem(value: 'en', child: Text("English")),
                DropdownMenuItem(value: 'bn', child: Text("বাংলা")),
              ],
              onChanged: (value) {
                if (value != null) {
                  controller.changeLanguage(value);
                }
              },
            )),

            const SizedBox(height: 20),

            Text("theme".tr,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            // Dark/Light theme mode switch
            Obx(() => SwitchListTile(
              title: Text(controller.isDarkMode.value
                  ? "dark_mode".tr
                  : "light_mode".tr),
              value: controller.isDarkMode.value,
              onChanged: (value) {
                controller.toggleTheme(value);
              },
            )),

            const Spacer(),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: Text("logout".tr),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  authController.logout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
