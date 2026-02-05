import 'package:e_comm_app/presentations/auth/controllers/auth_controller.dart';
import 'package:e_comm_app/services/auth_service.dart';
import 'package:get/get.dart';
import '../../presentations/cart/controllers/cart_controller.dart';
import '../../presentations/products_details/controllers/product_detail_controller.dart';
import '../../presentations/products_list/controller/product_controller.dart';
import '../../services/product_service.dart';
import '../../presentations/profile/controllers/profile_controller.dart';
import '../../services/user_service.dart';
import '../local_storage/storage_service.dart';
import '/core/network/dio_client.dart';

class DependencyInjection {
  static void init() {
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.lazyPut<ProductService>(() => ProductService(Get.find()), fenix: true);
    Get.lazyPut<AuthService>(() => AuthService(Get.find<DioClient>()), fenix: true,);
    Get.put<DioClient>(DioClient.instance, permanent: true);
    Get.lazyPut<ProductService>(() => ProductService(Get.find()), fenix: true);
    Get.lazyPut<UserService>(() => UserService(Get.find()), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(authServices: Get.find<AuthService>()), fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(Get.find()), fenix: true);
    Get.put<CartController>(CartController(), permanent: true);
    Get.lazyPut<ProfileController>(() => ProfileController(Get.find()), fenix: true);
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(productServices: Get.find<ProductService>()), fenix: true,
    );
  }
}
