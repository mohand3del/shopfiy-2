import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';
import '../../domain/usecases/resend_otp_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/validate_otp_usecase.dart';
import '../../domain/usecases/verify_email_usecase.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final ValidateOtpUseCase validateOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.verifyEmailUseCase,
    required this.validateOtpUseCase,
    required this.resendOtpUseCase,
  }) : super(const AuthInitial());

  // ─── Sign In ─────────────────────────────────────────────────────────────
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final (user, failure) = await signInUseCase(
      email: email,
      password: password,
    );

    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(AuthSuccess(user!));
    }
  }

  // ─── Sign Up ─────────────────────────────────────────────────────────────
  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());

    final (user, failure) = await signUpUseCase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );

    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(const AuthRegistrationSuccess());
    }
  }

  // ─── Verify email (registration OTP) ─────────────────────────────────────
  Future<void> verifyEmail({
    required String email,
    required String otp,
  }) async {
    emit(const AuthLoading());

    final (_, failure) = await verifyEmailUseCase(
      email: email,
      otp: otp,
    );

    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(const AuthVerificationSuccess());
    }
  }

  /// Resend OTP after registration (`/api/auth/resend-otp`).
  Future<void> resendRegistrationOtp(String email) async {
    emit(const AuthLoading());
    final result = await resendOtpUseCase(email: email.trim());
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthOtpResent()),
    );
  }

  // ─── Validate OTP (e.g. forgot-password flow) ────────────────────────────
  Future<void> validateOtp({
    required String email,
    required String otp,
  }) async {
    emit(const AuthLoading());

    final (_, failure) = await validateOtpUseCase(
      email: email,
      otp: otp,
    );

    if (failure != null) {
      emit(AuthFailure(failure.message));
    } else {
      emit(const AuthVerificationSuccess());
    }
  }

  // ─── Reset to initial ────────────────────────────────────────────────────
  void reset() => emit(const AuthInitial());
}
