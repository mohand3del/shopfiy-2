import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:practical_cubit/core/errors/dio_error_handler.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../mappers/user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final DioErrorHandler _dioErrorHandler;

  const AuthRepositoryImpl(this._remoteDataSource, this._dioErrorHandler);

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

      await _saveTokens(
        accessToken: model.token,
        refreshToken: model.refreshToken,
      );

      return (UserMapper.toEntity(model), null);
    } on DioException catch (e) {
      return (null, _dioErrorHandler.handle(e));
    } catch (e) {
      return (null, _dioErrorHandler.handle(e));
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
      return (null, _dioErrorHandler.handle(e));
    } catch (e) {
      return (null, _dioErrorHandler.handle(e));
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
      return (null, _dioErrorHandler.handle(e));
    } catch (e) {
      return (null, _dioErrorHandler.handle(e));
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
      return (null, _dioErrorHandler.handle(e));
    } catch (e) {
      return (null, _dioErrorHandler.handle(e));
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
      return Left(_dioErrorHandler.handle(e));
    } catch (e) {
      return Left(_dioErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> resendOtp({required String email}) async {
    try {
      await _remoteDataSource.resendOtp(email: email);
      return Right(unit);
    } on DioException catch (e) {
      return Left(_dioErrorHandler.handle(e));
    } catch (e) {
      return Left(_dioErrorHandler.handle(e));
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
      return Left(_dioErrorHandler.handle(e));
    } catch (e) {
      return Left(_dioErrorHandler.handle(e));
    }
  }

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
}
