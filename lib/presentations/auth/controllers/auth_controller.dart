import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/local_storage/storage_service.dart';
import '/core/routes/app_routes.dart';
import '/data/models/auth/login_request.dart';

import '/core/errors/app_exception.dart';
import '/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  
  AuthController({
    required AuthService authServices
}): _authService = authServices;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }


  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final response = await _authService.login(
        LoginRequest(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );
      final storageService = Get.find<StorageService>();
      await storageService.saveToken(response.token);
      await storageService.saveUserId(1);
      Get.offAllNamed(AppRoutes.home);
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
