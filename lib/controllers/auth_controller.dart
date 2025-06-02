import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapping_quality/pages/home_page.dart';
import 'package:tapping_quality/services/auth_service.dart';

class AuthController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  Future<void> login() async {
    isLoading.value = true;
    final authService = AuthService();
    final isAuthenticated = await authService.authenticate(
      email.value,
      password.value,
    );
    if (isAuthenticated) {
      Get.snackbar(
        'Success',
        'Login berhasil',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      Get.to(HomePage());
    } else {
      Get.snackbar(
        'Error',
        'Email atau password salah',
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
    }
    isLoading.value = false;
  }
}
