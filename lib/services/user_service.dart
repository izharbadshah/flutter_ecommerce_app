import 'package:dio/dio.dart';
import 'package:e_comm_app/core/config/environment_config.dart';
import '../data/models/user.dart';
import '/core/errors/app_exception.dart';
import '/core/network/dio_client.dart';


class UserService {
  final DioClient _dioClient;

  UserService(this._dioClient);

  Future<User> fetchUser(int userId) async {
    try {
      final response = await _dioClient.dio.get(EnvironmentConfig.userById(userId));
      return User.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw mapDioException(e);
    } catch (e) {
      throw ParsingException(message: e.toString());
    }
  }
}
