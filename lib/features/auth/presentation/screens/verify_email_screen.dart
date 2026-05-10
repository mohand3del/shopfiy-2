import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:practical_cubit/core/presentation/app_snackbar.dart';
import 'package:practical_cubit/core/presentation/auth_pinput_theme.dart';
import 'package:practical_cubit/core/routes/app_routes_constant.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_state.dart';

import '../widgets/custom_button.dart';

/// Enter OTP from email after registration (`/api/auth/verify-email`, `/api/auth/resend-otp`).
class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _otpController = TextEditingController();

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return email;
    final visible = name.substring(0, 2);
    return '$visible••••@$domain';
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailTrimmed = widget.email.trim();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          AppSnackBar.error(context, state.message);
        } else if (state is AuthVerificationSuccess) {
          AppSnackBar.success(
            context,
            'Email verified! You can sign in now.',
          );
          context.go(AppRoutesConstant.loginScreen);
        } else if (state is AuthOtpResent) {
          AppSnackBar.info(
            context,
            'We sent a new code to your email.',
          );
          _otpController.clear();
          context.read<AuthCubit>().reset();
        }
      },
      builder: (context, state) {
        final loading = state is AuthLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/new_pass_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),
                      const Icon(
                        Icons.mark_email_unread_outlined,
                        size: 72,
                        color: Color(0xff004CFF),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Verify your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff202020),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        emailTrimmed.isEmpty
                            ? 'Enter the code we sent you.'
                            : 'Enter the code we sent to ${_maskEmail(emailTrimmed)}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Center(
                        child: Pinput(
                          length: 6,
                          controller: _otpController,
                          enabled: !loading,
                          autofocus: true,
                          defaultPinTheme: buildAuthPinTheme(),
                          focusedPinTheme: buildAuthPinTheme(
                            border: Border.all(color: kAuthPinBrandBlue, width: 2),
                          ),
                          submittedPinTheme: buildAuthPinTheme(
                            border: Border.all(
                              color: kAuthPinBrandBlue.withValues(alpha: 0.35),
                              width: 2,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          separatorBuilder: (index) =>
                              const SizedBox(width: 10),
                          onCompleted: (pin) {
                            if (loading || emailTrimmed.isEmpty) return;
                            context.read<AuthCubit>().verifyEmail(
                                  email: emailTrimmed,
                                  otp: pin,
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextButton(
                        onPressed: loading || emailTrimmed.isEmpty
                            ? null
                            : () {
                                context
                                    .read<AuthCubit>()
                                    .resendRegistrationOtp(emailTrimmed);
                              },
                        child: const Text(
                          'Resend code',
                          style: TextStyle(
                            color: Color(0xff004CFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: 'Verify',
                        onPressed: loading
                            ? null
                            : () {
                                final otp = _otpController.text.trim();
                                if (emailTrimmed.isEmpty) {
                                  AppSnackBar.error(
                                    context,
                                    'Missing email. Go back and register again.',
                                  );
                                  return;
                                }
                                if (otp.length != 6) {
                                  AppSnackBar.error(
                                    context,
                                    'Enter all 6 digits of the verification code.',
                                  );
                                  return;
                                }
                                context.read<AuthCubit>().verifyEmail(
                                      email: emailTrimmed,
                                      otp: otp,
                                    );
                              },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () =>
                              context.go(AppRoutesConstant.loginScreen),
                          child: const Text(
                            'Back to sign in',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
