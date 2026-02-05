import 'package:get/get.dart';
import '/data/models/product.dart';
import '/services/product_service.dart';
import '/core/errors/app_exception.dart';

class ProductController extends GetxController {
  final ProductService _productService;

  ProductController(this._productService);

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final products = <Product>[].obs;
  final filteredProducts = <Product>[].obs;
  final categories = <String>[].obs;
  final selectedCategory = Rxn<String>();
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final [productList, categoryList] = await Future.wait([
        _productService.fetchAllProducts(),
        _productService.fetchCategories(),
      ]);

      products.value = productList as List<Product>;
      categories.value = categoryList as List<String>;
      filteredProducts.value = products;
    } on AppException catch (e) {
      errorMessage.value = e.message;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }

  Future<void> filterByCategory(String? category) async {
    selectedCategory.value = category;

    if (category == null) {
      filteredProducts.value = _applySearch(products, searchQuery.value);
      return;
    }

    try {
      final productList = await _productService.fetchProductsByCategory(category);
      filteredProducts.value = _applySearch(productList, searchQuery.value);
    } on AppException catch (e) {
      errorMessage.value = e.message;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query.toLowerCase().trim();

    final baseList = selectedCategory.value == null
        ? products
        : products.where((p) => p.category == selectedCategory.value).toList();

    filteredProducts.value = _applySearch(baseList, searchQuery.value);
  }

  List<Product> _applySearch(List<Product> productList, String query) {
    if (query.isEmpty) return productList;
    return productList.where((p) {
      return p.title.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query);
    }).toList();
  }
}
