import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practical_cubit/core/errors/error_model.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/auth/domain/entities/user_entity.dart';
import 'package:practical_cubit/features/auth/domain/repositories/auth_repository.dart';
import 'package:practical_cubit/features/auth/domain/usecases/request_password_reset_usecase.dart';

class _Repo implements AuthRepository {
  _Repo({required this.resetResult});

  final Either<Failure, Unit> resetResult;

  @override
  Future<(UserEntity?, Failure?)> signIn({
    required String email,
    required String password,
  }) =>
      throw UnimplementedError();

  @override
  Future<(UserEntity?, Failure?)> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) =>
      throw UnimplementedError();

  @override
  Future<(bool?, Failure?)> verifyEmail({
    required String email,
    required String otp,
  }) =>
      throw UnimplementedError();

  @override
  Future<(bool?, Failure?)> validateOtp({
    required String email,
    required String otp,
  }) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> requestPasswordReset({
    required String email,
  }) async =>
      resetResult;

  @override
  Future<Either<Failure, Unit>> resendOtp({required String email}) =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) =>
      throw UnimplementedError();
}

void main() {
  test('returns Right(unit) when repository succeeds', () async {
    final useCase = RequestPasswordResetUseCase(
      _Repo(resetResult: Right(unit)),
    );

    final result = await useCase(email: 'u@example.com');

    expect(result.isRight(), isTrue);
    result.fold(
      (_) => fail('expected Right'),
      (u) => expect(u, unit),
    );
  });

  test('returns Left when repository fails', () async {
    final useCase = RequestPasswordResetUseCase(
      _Repo(
        resetResult: Left(
          Failure(
            error: ErrorModel(statusCode: 422, message: 'invalid'),
          ),
        ),
      ),
    );

    final result = await useCase(email: 'x@example.com');

    expect(result.isLeft(), isTrue);
    result.fold(
      (f) {
        expect(f, isA<Failure>());
        expect(f.message, 'invalid');
      },
      (_) => fail('expected Left'),
    );
  });
}
