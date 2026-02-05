import 'package:get/get.dart';
import '../../presentations/auth/views/login_page.dart';
import '../../presentations/dashboard/home_page.dart';
import '../../presentations/products_details/views/product_detail_page.dart';
import 'app_routes.dart';


class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
    ),
  ];
}
