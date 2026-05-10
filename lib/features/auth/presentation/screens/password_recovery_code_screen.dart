import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_cubit/core/presentation/app_snackbar.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/password_recovery_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/password_recovery_state.dart';
import 'package:practical_cubit/features/auth/presentation/screens/new_password.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class PasswordRecoveryCodeScreen extends StatefulWidget {
  const PasswordRecoveryCodeScreen({super.key, required this.email});

  final String email;

  @override
  State<PasswordRecoveryCodeScreen> createState() =>
      _PasswordRecoveryCodeScreenState();
}

class _PasswordRecoveryCodeScreenState extends State<PasswordRecoveryCodeScreen> {
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
    return BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
      listener: (context, state) {
        if (state is PasswordRecoveryFailure) {
          AppSnackBar.error(context, state.message);
        } else if (state is PasswordRecoveryCodeResent) {
          AppSnackBar.success(
            context,
            'A new code has been sent to your email.',
          );
          context.read<PasswordRecoveryCubit>().resetFlow();
        } else if (state is PasswordRecoveryOtpValidated) {
          final otp = _otpController.text.trim();
          AppSnackBar.success(context, 'Code verified.');
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (_) => BlocProvider.value(
                value: context.read<PasswordRecoveryCubit>(),
                child: NewPassword(email: widget.email, otp: otp),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final loading = state is PasswordRecoveryLoading;

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
              Column(
                children: [
                  const SizedBox(height: 50),
                  const SizedBox(height: 80),
                  const Center(child: ProfileAvatar()),
                  const SizedBox(height: 30),
                  const Text(
                    'Enter verification code',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'We sent a code to ${_maskEmail(widget.email)}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: CustomTextField(
                      hint: 'Verification code',
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: TextButton(
                      onPressed: loading
                          ? null
                          : () {
                              context
                                  .read<PasswordRecoveryCubit>()
                                  .resendCode(widget.email);
                            },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff004CFF),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Send code again',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Continue',
                        onPressed: loading
                            ? null
                            : () {
                                final otp = _otpController.text.trim();
                                if (otp.length < 4) {
                                  AppSnackBar.error(
                                    context,
                                    'Enter the code from your email.',
                                  );
                                  return;
                                }
                                context.read<PasswordRecoveryCubit>().verifyOtpAndContinue(
                                      email: widget.email,
                                      otp: otp,
                                    );
                              },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
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

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Icons.mark_email_unread_outlined,
          size: 70,
          color: Colors.grey,
        ),
      ),
    );
  }
}
