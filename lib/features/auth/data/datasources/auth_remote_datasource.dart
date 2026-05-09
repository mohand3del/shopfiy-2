import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  const AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/api/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return UserModel.fromJson(_extractPayload(response.data));
  }

  @override
  Future<UserModel> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/api/auth/register',
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    );

    return UserModel.fromJson(_extractPayload(response.data));
  }

  Map<String, dynamic> _extractPayload(dynamic raw) {
    if (raw is! Map<String, dynamic>) return <String, dynamic>{};

    final data = raw['data'];
    if (data is Map<String, dynamic>) return data;

    final user = raw['user'];
    if (user is Map<String, dynamic>) return user;

    return raw;
  }
}
