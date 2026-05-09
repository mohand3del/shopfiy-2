import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static const String baseUrl = 'https://accessories-eshop.runasp.net'; // 🔁 Change this

  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
    ]);
  }

  Dio get dio => _dio;
}

// ─── Auth Interceptor ────────────────────────────────────────────────────────
// Automatically attaches the saved token to every request
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 globally (e.g., logout user)
    if (err.response?.statusCode == 401) {
      // You can trigger a logout event here
    }
    handler.next(err);
  }
}

// ─── Logging Interceptor ─────────────────────────────────────────────────────
// Prints request/response info in debug mode
class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('┌──────────────────────────────────────────────');
    print('│ REQUEST: ${options.method} ${options.uri}');
    print('│ Body: ${options.data}');
    print('└──────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('┌──────────────────────────────────────────────');
    print('│ RESPONSE: ${response.statusCode}');
    print('│ Data: ${response.data}');
    print('└──────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('┌──────────────────────────────────────────────');
    print('│ ERROR: ${err.response?.statusCode} ${err.message}');
    print('└──────────────────────────────────────────────');
    handler.next(err);
  }
}
