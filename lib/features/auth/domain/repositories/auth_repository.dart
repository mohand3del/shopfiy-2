import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import 'package:practical_cubit/core/errors/failure.dart';

// Abstract contract — the domain layer only knows about this interface,
// NOT the implementation detail (Dio, HTTP, etc.)
abstract class AuthRepository {
  Future<(UserEntity?, Failure?)> signIn({
    required String email,
    required String password,
  });

  /// Register returns HTTP 204 with no body; [UserEntity] is always null on success.
  Future<(UserEntity?, Failure?)> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

  /// Returns `(true, null)` on success.
  Future<(bool?, Failure?)> verifyEmail({
    required String email,
    required String otp,
  });

  /// Returns `(true, null)` on success (e.g. forgot-password OTP step).
  Future<(bool?, Failure?)> validateOtp({
    required String email,
    required String otp,
  });

  /// POST `/api/auth/forgot-password` — sends reset OTP to email ([ForgotPasswordRequest]).
  Future<Either<Failure, Unit>> requestPasswordReset({required String email});

  /// POST `/api/auth/resend-otp` — resend OTP ([ResendOtpRequest]).
  Future<Either<Failure, Unit>> resendOtp({required String email});

  /// POST `/api/auth/reset-password` — set new password with OTP ([ResetPasswordRequest]).
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  });
}
