import 'package:get/get.dart';
import '../../../data/models/product.dart';
import '../../../services/product_service.dart';
import '/core/errors/app_exception.dart';


class ProductDetailController extends GetxController {
  final ProductService _productService;

  ProductDetailController({
    required ProductService productServices,
}) : _productService = productServices;

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final product = Rxn<Product>();

  Future<void> fetchProduct(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      product.value = await _productService.fetchProductById(id);
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
