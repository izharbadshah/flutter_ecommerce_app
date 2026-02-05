import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  final GetStorage _box = GetStorage();

  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _darkModeKey = 'dark_mode';

  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = _box.read<bool>(_darkModeKey) ?? false;
  }

  String? get token => _box.read<String>(_tokenKey);

  Future<void> saveToken(String token) async {
    await _box.write(_tokenKey, token);
  }

  Future<void> removeToken() async {
    await _box.remove(_tokenKey);
  }

  bool get isLoggedIn => token != null && token!.isNotEmpty;
  int? get userId => _box.read<int>(_userIdKey);

  Future<void> saveUserId(int userId) async {
    await _box.write(_userIdKey, userId);
  }

  Future<void> removeUserId() async {
    await _box.remove(_userIdKey);
  }

  Future<void> toggleDarkMode() async {
    isDarkMode.value = !isDarkMode.value;
    await _box.write(_darkModeKey, isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setDarkMode(bool enabled) async {
    isDarkMode.value = enabled;
    await _box.write(_darkModeKey, enabled);
    Get.changeThemeMode(enabled ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> clear() async {
    await _box.remove(_tokenKey);
    await _box.remove(_userIdKey);
  }
}
