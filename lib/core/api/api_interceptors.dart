import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptor extends Interceptor {
  final String? _token;

  ApiInterceptor(this._token);

  static const _accessTokenKey = 'auth_token';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _token ?? await _readStoredToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers.putIfAbsent('Accept', () => 'application/json');
    handler.next(options);
  }

  Future<String?> _readStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
