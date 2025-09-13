import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  final TextEditingController emailController =
  TextEditingController(text: "eve.holt@reqres.in");
  final TextEditingController passwordController =
  TextEditingController(text: "cityslicka");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("login".tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "email".tr,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "password".tr,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                controller.login(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              },
              child: Text("login".tr),
            ),
          ],
        )),
      ),
    );
  }
}
