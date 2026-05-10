import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository _repository;

  const ResetPasswordUseCase(this._repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    return _repository.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
  }
}
