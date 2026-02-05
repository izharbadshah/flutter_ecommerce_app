import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('─── REQUEST ─────────────────────────────');
      print('Method : ${options.method}');
      print('URL    : ${options.uri}');
      print('Headers: ${options.headers}');
      if (options.data != null) print('Data   : ${options.data}');
      print('─────────────────────────────────────────');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('─── RESPONSE ────────────────────────────');
      print('Status : ${response.statusCode}');
      print('Data   : ${response.data}');
      print('─────────────────────────────────────────');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('─── ERROR ───────────────────────────────');
      print('Type   : ${err.type}');
      print('Message: ${err.message}');
      if (err.response != null) {
        print('Status : ${err.response?.statusCode}');
        print('Data   : ${err.response?.data}');
      }
      print('─────────────────────────────────────────');
    }
    super.onError(err, handler);
  }
}
