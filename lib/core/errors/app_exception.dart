import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({String message = 'Network error. Please check your internet connection.'})
      : super(message: message);
}

class ServerException extends AppException {
  ServerException({required String message, required int statusCode})
      : super(message: message, statusCode: statusCode);
}

class AuthException extends AppException {
  AuthException({String message = 'Authentication failed.'})
      : super(message: message, statusCode: 401);
}

class TimeoutException extends AppException {
  TimeoutException({String message = 'Request timed out.'})
      : super(message: message);
}

class ParsingException extends AppException {
  ParsingException({String message = 'Failed to parse response data.'})
      : super(message: message);
}

AppException mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutException();

    case DioExceptionType.connectionError:
      return NetworkException();

    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode ?? 500;
      final data = error.response?.data?.toString() ?? 'Unknown error';
      if (statusCode == 401) return AuthException(message: data);
      return ServerException(message: data, statusCode: statusCode);

    case DioExceptionType.cancel:
      return AppException(message: 'Request was cancelled.');

    default:
      return AppException(message: error.message ?? 'An unexpected error occurred.');
  }
}
