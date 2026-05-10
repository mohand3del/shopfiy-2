import 'package:equatable/equatable.dart';

abstract class PasswordRecoveryState extends Equatable {
  const PasswordRecoveryState();

  @override
  List<Object?> get props => [];
}

class PasswordRecoveryInitial extends PasswordRecoveryState {
  const PasswordRecoveryInitial();
}

class PasswordRecoveryLoading extends PasswordRecoveryState {
  const PasswordRecoveryLoading();
}

class PasswordRecoveryFailure extends PasswordRecoveryState {
  final String message;

  const PasswordRecoveryFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Forgot-password email accepted; navigate to OTP step.
class PasswordRecoveryResetEmailSent extends PasswordRecoveryState {
  const PasswordRecoveryResetEmailSent();
}

/// OTP passed `/api/auth/validate-otp`; navigate to new password.
class PasswordRecoveryOtpValidated extends PasswordRecoveryState {
  const PasswordRecoveryOtpValidated();
}

/// `/api/auth/reset-password` succeeded.
class PasswordRecoveryPasswordChanged extends PasswordRecoveryState {
  const PasswordRecoveryPasswordChanged();
}

/// `/api/auth/resend-otp` succeeded.
class PasswordRecoveryCodeResent extends PasswordRecoveryState {
  const PasswordRecoveryCodeResent();
}
