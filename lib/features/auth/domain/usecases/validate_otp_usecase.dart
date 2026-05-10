import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class ValidateOtpUseCase {
  final AuthRepository _repository;

  const ValidateOtpUseCase(this._repository);

  /// Returns `(true, null)` when OTP validation succeeds.
  Future<(bool?, Failure?)> call({
    required String email,
    required String otp,
  }) {
    return _repository.validateOtp(email: email, otp: otp);
  }
}
