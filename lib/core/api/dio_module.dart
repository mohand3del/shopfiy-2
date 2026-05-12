import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constant/api_endpoints.dart';
import 'api_interceptors.dart';

class DioModule {
  final ApiInterceptor _apiInterceptor;

  DioModule(this._apiInterceptor);

  Dio get _dio {
    final dio = Dio();

    dio.options
      ..baseUrl = ApiEndpoints.baseUrl
      ..connectTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(_apiInterceptor);

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );

    return dio;
  }

  Dio get dioInstance => _dio;
}
