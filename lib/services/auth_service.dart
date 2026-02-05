import 'package:dio/dio.dart';
import 'package:e_comm_app/core/config/environment_config.dart';
import '../data/models/auth/login_request.dart';
import '../data/models/auth/login_response.dart';
import '/core/errors/app_exception.dart';
import '/core/network/dio_client.dart';

class AuthService {
  final DioClient _dioClient;

  AuthService(this._dioClient);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        EnvironmentConfig.login,
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
