import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'core/dependency_injection/dependency_injection.dart';
import 'core/local_storage/storage_service.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  DependencyInjection.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<StorageService>();
    return GetMaterialApp(
      title: 'ShopZone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: storageService.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialRoute: storageService.isLoggedIn ? AppRoutes.home : AppRoutes.login,
      getPages: AppPages.routes,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
