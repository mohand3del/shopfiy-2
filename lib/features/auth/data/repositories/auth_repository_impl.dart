import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/user_mapper.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  const AuthRepositoryImpl(this._remoteDataSource);

  static const _accessTokenKey = 'auth_token';
  static const _refreshTokenKey = 'auth_refresh_token';

  @override
  Future<(UserEntity?, Failure?)> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );

      await _saveTokens(accessToken: model.token, refreshToken: model.refreshToken);

      return (UserMapper.toEntity(model), null);
    } on DioException catch (e) {
      return (null, _handleDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  @override
  Future<(UserEntity?, Failure?)> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      return (null, null);
    } on DioException catch (e) {
      return (null, _handleDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  @override
  Future<(bool?, Failure?)> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      await _remoteDataSource.verifyEmail(email: email, otp: otp);
      return (true, null);
    } on DioException catch (e) {
      return (null, _handleDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  @override
  Future<(bool?, Failure?)> validateOtp({
    required String email,
    required String otp,
  }) async {
    try {
      await _remoteDataSource.validateOtp(email: email, otp: otp);
      return (true, null);
    } on DioException catch (e) {
      return (null, _handleDioError(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> requestPasswordReset({
    required String email,
  }) async {
    try {
      await _remoteDataSource.forgotPassword(email: email);
      return Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resendOtp({required String email}) async {
    try {
      await _remoteDataSource.resendOtp(email: email);
      return Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      return Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────

  Future<void> _saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    if (refreshToken.isNotEmpty) {
      await prefs.setString(_refreshTokenKey, refreshToken);
    }
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timed out. Check your internet.');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection.');
      default:
        final statusCode = e.response?.statusCode;
        final message = _extractErrorMessage(e.response?.data, e.message);

        if (statusCode == 401) return UnauthorizedFailure(message);
        if (statusCode == 400 || statusCode == 422) return ValidationFailure(message);
        return ServerFailure(message);
    }
  }

  String _extractErrorMessage(dynamic data, String? fallback) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic> && errors.isNotEmpty) {
        final parts = <String>[];
        errors.forEach((field, value) {
          if (value is List) {
            for (final item in value) {
              final text = item?.toString().trim();
              if (text != null && text.isNotEmpty) {
                parts.add('$field: $text');
              }
            }
          }
        });
        if (parts.isNotEmpty) return parts.join('\n');
      }

      final message = data['message']?.toString().trim();
      if (message != null && message.isNotEmpty) return message;

      final detail = data['detail']?.toString().trim();
      if (detail != null && detail.isNotEmpty) return detail;

      final title = data['title']?.toString().trim();
      if (title != null && title.isNotEmpty) return title;
    }

    return fallback ?? 'Something went wrong';
  }
}
