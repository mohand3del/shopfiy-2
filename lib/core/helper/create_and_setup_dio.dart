import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio get createAndSetupDio {
  Dio dio = Dio();
  // Set connection timeout. This defines how long Dio should wait to establish a connection.
  // Set receive timeout. This defines how long Dio should wait for the server's response after the connection is made.
  dio.options
    ..connectTimeout = const Duration(seconds: 10)
    ..receiveTimeout = const Duration(seconds: 10);

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

/*
In the context of HTTP requests, interceptors are functions or classes 
that allow you to hook into the request/response lifecycle. 

They act as a middle layer between your application and the server, 
allowing you to manipulate requests or responses before they are sent 
or after they are received. 

In simpler terms, interceptors allow you to intercept HTTP requests 
and responses and modify them if needed.
*/
class ClassName {
  //private constructor
  ClassName._();
}
