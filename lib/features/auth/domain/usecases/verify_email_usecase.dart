import 'package:practical_cubit/core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository _repository;

  const VerifyEmailUseCase(this._repository);

  /// Returns `(true, null)` when verification succeeds.
  Future<(bool?, Failure?)> call({
    required String email,
    required String otp,
  }) {
    return _repository.verifyEmail(email: email, otp: otp);
  }
}
