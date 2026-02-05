import 'package:dio/dio.dart';
import 'package:e_comm_app/core/config/environment_config.dart';
import '../data/models/product.dart';
import '/core/errors/app_exception.dart';
import '/core/network/dio_client.dart';


class ProductService {
  final DioClient _dioClient;

  ProductService(this._dioClient);

  Future<List<Product>> fetchAllProducts() async {
    try {
      final response = await _dioClient.dio.get(EnvironmentConfig.products);
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (e) {
      throw ParsingException(message: e.toString());
    }
  }

  Future<Product> fetchProductById(int id) async {
    try {
      final response = await _dioClient.dio.get(EnvironmentConfig.productById(id));
      return Product.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (e) {
      throw ParsingException(message: e.toString());
    }
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    try {
      final response = await _dioClient.dio.get(EnvironmentConfig.productsByCategory(category));
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => Product.fromJson(json as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (e) {
      throw ParsingException(message: e.toString());
    }
  }

  Future<List<String>> fetchCategories() async {
    try {
      final response = await _dioClient.dio.get(EnvironmentConfig.categories);
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((item) => item as String).toList();
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (e) {
      throw ParsingException(message: e.toString());
    }
  }
}
