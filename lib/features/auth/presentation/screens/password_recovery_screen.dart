import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_cubit/core/di/service_locator.dart';
import 'package:practical_cubit/core/enums/snack_bar_type.dart';
import 'package:practical_cubit/core/extensions/show_snack_bar_extension.dart';
import 'package:practical_cubit/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/validate_otp_usecase.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/password_recovery_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/password_recovery_state.dart';
import 'package:practical_cubit/features/auth/presentation/screens/password_recovery_code_screen.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

/// Entry point for forgot password: collects email and calls `/api/auth/forgot-password`.
class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _goToCodeStep(BuildContext context, String email) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<PasswordRecoveryCubit>(),
          child: PasswordRecoveryCodeScreen(email: email),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
      listener: (context, state) {
        if (state is PasswordRecoveryFailure) {
          context.showCustomSnackBar(state.message, type: SnackBarType.error);
        } else if (state is PasswordRecoveryResetEmailSent) {
          final email = _emailController.text.trim();
          context.showCustomSnackBar(
            'If this email is registered, you will receive a code shortly.',
            type: SnackBarType.info,
          );
          context.read<PasswordRecoveryCubit>().resetFlow();
          _goToCodeStep(context, email);
        }
      },
      builder: (context, state) {
        final loading = state is PasswordRecoveryLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset('assets/images/pass_bg.png', fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: const Icon(
                            Icons.lock_reset_rounded,
                            size: 70,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Forgot password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'Enter your email address. We will send you a code to reset your password.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 36),
                    CustomTextField(
                      hint: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Next',
                        onPressed: loading
                            ? null
                            : () {
                                final email = _emailController.text.trim();
                                if (email.isEmpty) {
                                  context.showCustomSnackBar(
                                    'Please enter your email address.',
                                    type: SnackBarType.error,
                                  );
                                  return;
                                }
                                context
                                    .read<PasswordRecoveryCubit>()
                                    .sendResetEmail(email);
                              },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              if (loading)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF0052FF),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Pushes [PasswordRecoveryScreen] with a dedicated [PasswordRecoveryCubit].
void openPasswordRecoveryFlow(BuildContext context) {
  Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (_) => PasswordRecoveryCubit(
          requestPasswordResetUseCase: getIt<RequestPasswordResetUseCase>(),
          resendOtpUseCase: getIt<ResendOtpUseCase>(),
          resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
          validateOtpUseCase: getIt<ValidateOtpUseCase>(),
        ),
        child: const PasswordRecoveryScreen(),
      ),
    ),
  );
}
