import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:practical_cubit/core/errors/failure.dart';
import '../../domain/usecases/request_password_reset_usecase.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/validate_otp_usecase.dart';
import 'password_recovery_state.dart';

class PasswordRecoveryCubit extends Cubit<PasswordRecoveryState> {
  final RequestPasswordResetUseCase _requestPasswordResetUseCase;
  final ResendOtpUseCase _resendOtpUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final ValidateOtpUseCase _validateOtpUseCase;

  PasswordRecoveryCubit({
    required RequestPasswordResetUseCase requestPasswordResetUseCase,
    required ResendOtpUseCase resendOtpUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required ValidateOtpUseCase validateOtpUseCase,
  })  : _requestPasswordResetUseCase = requestPasswordResetUseCase,
        _resendOtpUseCase = resendOtpUseCase,
        _resetPasswordUseCase = resetPasswordUseCase,
        _validateOtpUseCase = validateOtpUseCase,
        super(const PasswordRecoveryInitial());

  Future<void> sendResetEmail(String email) async {
    emit(const PasswordRecoveryLoading());
    final Either<Failure, Unit> result =
        await _requestPasswordResetUseCase(email: email);
    result.fold(
      (failure) => emit(PasswordRecoveryFailure(failure.message)),
      (_) => emit(const PasswordRecoveryResetEmailSent()),
    );
  }

  Future<void> resendCode(String email) async {
    emit(const PasswordRecoveryLoading());
    final Either<Failure, Unit> result = await _resendOtpUseCase(email: email);
    result.fold(
      (failure) => emit(PasswordRecoveryFailure(failure.message)),
      (_) => emit(const PasswordRecoveryCodeResent()),
    );
  }

  Future<void> verifyOtpAndContinue({
    required String email,
    required String otp,
  }) async {
    emit(const PasswordRecoveryLoading());
    final (_, failure) = await _validateOtpUseCase(email: email, otp: otp);
    if (failure != null) {
      emit(PasswordRecoveryFailure(failure.message));
      return;
    }
    emit(const PasswordRecoveryOtpValidated());
  }

  Future<void> submitNewPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(const PasswordRecoveryLoading());
    final Either<Failure, Unit> result = await _resetPasswordUseCase(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(PasswordRecoveryFailure(failure.message)),
      (_) => emit(const PasswordRecoveryPasswordChanged()),
    );
  }

  void resetFlow() => emit(const PasswordRecoveryInitial());
}
