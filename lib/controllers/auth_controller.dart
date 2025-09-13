import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final storage = GetStorage();

  // Observables
  var isLoading = false.obs;
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }


  void _loadToken() {
    String? savedToken = storage.read('token');
    if (savedToken != null && savedToken.isNotEmpty) {
      token.value = savedToken;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(AppRoutes.articles);
      });
    }
  }


  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty");
      return;
    }

    try {
      isLoading.value = true;

      // Dummy response instead of real API call (for dummy api)
      final result = {
        "token": "dummy_token_12345", // <- fake token for testing
      };

      // OR if you want to simulate API call, uncomment this (Due to some problem I have to make this a comment)
      /*
    final result = await ApiService.postRequest(
      "https://reqres.in/api/login",
      {
        "email": email,
        "password": password,
      },
    );
    */

      if (result.containsKey("token")) {
        token.value = result["token"]!;
        storage.write('token', token.value);

        Get.snackbar("Success", "Login successful");
        Get.offAllNamed(AppRoutes.articles);
      } else {
        Get.snackbar("Error", "Invalid email or password");
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    } finally {
      isLoading.value = false;
    }
  }


  void logout() {
    token.value = '';
    storage.remove('token');
    Get.offAllNamed(AppRoutes.login);
  }
}
