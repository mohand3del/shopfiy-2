import 'package:dio/dio.dart';
import '../models/current_user_model.dart';
import '../models/login_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  /// POST `/api/auth/verify-email` — body: [VerifyEmailRequest] (`email`, `otp`).
  Future<void> verifyEmail({
    required String email,
    required String otp,
  });

  /// POST `/api/auth/validate-otp` — body: [ValidateOtpRequest] (`email`, `otp`).
  Future<void> validateOtp({
    required String email,
    required String otp,
  });

  /// POST `/api/auth/forgot-password` — body: [ForgotPasswordRequest] (`email`).
  Future<void> forgotPassword({required String email});

  /// POST `/api/auth/resend-otp` — body: [ResendOtpRequest] (`email`).
  Future<void> resendOtp({required String email});

  /// POST `/api/auth/reset-password` — body: [ResetPasswordRequest].
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
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
    final loginResponse = await _dio.post<Map<String, dynamic>>(
      '/api/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final loginJson = _asJsonMap(loginResponse.data);
    final tokens = LoginResponseModel.fromJson(loginJson);

    final meResponse = await _dio.get<Map<String, dynamic>>(
      '/api/auth/me',
      options: Options(
        headers: {'Authorization': 'Bearer ${tokens.accessToken}'},
      ),
    );

    final meJson = _asJsonMap(meResponse.data);
    final profile = CurrentUserModel.fromJson(meJson);

    return UserModel(
      id: profile.userId,
      name: profile.fullName,
      email: profile.email,
      token: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  @override
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    await _dio.post<void>(
      '/api/auth/register',
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    );
  }

  @override
  Future<void> verifyEmail({
    required String email,
    required String otp,
  }) async {
    await _dio.post<void>(
      '/api/auth/verify-email',
      data: {
        'email': email,
        'otp': otp,
      },
    );
  }

  @override
  Future<void> validateOtp({
    required String email,
    required String otp,
  }) async {
    await _dio.post<void>(
      '/api/auth/validate-otp',
      data: {
        'email': email,
        'otp': otp,
      },
    );
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _dio.post<void>(
      '/api/auth/forgot-password',
      data: {'email': email},
    );
  }

  @override
  Future<void> resendOtp({required String email}) async {
    await _dio.post<void>(
      '/api/auth/resend-otp',
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    await _dio.post<void>(
      '/api/auth/reset-password',
      data: {
        'email': email,
        'otp': otp,
        'newPassword': newPassword,
      },
    );
  }

  Map<String, dynamic> _asJsonMap(dynamic raw) {
    if (raw is! Map<String, dynamic>) return <String, dynamic>{};

    final data = raw['data'];
    if (data is Map<String, dynamic>) return data;

    return raw;
  }
}
