import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practical_cubit/core/errors/error_model.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/auth/domain/entities/user_entity.dart';
import 'package:practical_cubit/features/auth/domain/repositories/auth_repository.dart';
import 'package:practical_cubit/features/auth/domain/usecases/verify_email_usecase.dart';

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({required this.verifyResult});

  final (bool?, Failure?) verifyResult;

  @override
  Future<(bool?, Failure?)> validateOtp({
    required String email,
    required String otp,
  }) =>
      throw UnimplementedError();

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
  }) async =>
      verifyResult;

  @override
  Future<Either<Failure, Unit>> requestPasswordReset({
    required String email,
  }) =>
      throw UnimplementedError();

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
  test('VerifyEmailUseCase forwards to repository', () async {
    final repo = _FakeAuthRepository(verifyResult: (true, null));
    final useCase = VerifyEmailUseCase(repo);

    final result = await useCase(email: 'a@b.com', otp: '123456');

    expect(result.$1, true);
    expect(result.$2, isNull);
  });

  test('VerifyEmailUseCase returns failure from repository', () async {
    final repo = _FakeAuthRepository(
      verifyResult: (
        null,
        Failure(
          error: ErrorModel(statusCode: 422, message: 'bad otp'),
        ),
      ),
    );
    final useCase = VerifyEmailUseCase(repo);

    final result = await useCase(email: 'a@b.com', otp: '000000');

    expect(result.$1, isNull);
    expect(result.$2, isA<Failure>());
    expect(result.$2?.message, 'bad otp');
  });
}
