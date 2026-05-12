import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_cubit/core/enums/snack_bar_type.dart';
import 'package:practical_cubit/core/extensions/show_snack_bar_extension.dart';
import 'package:practical_cubit/core/routing/routes.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/password_recovery_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/password_recovery_state.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({
    super.key,
    required this.email,
    required this.otp,
  });

  final String email;
  final String otp;

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _confirmPassController.dispose();
    _newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordRecoveryCubit, PasswordRecoveryState>(
      listener: (context, state) {
        if (state is PasswordRecoveryFailure) {
          context.showCustomSnackBar(state.message, type: SnackBarType.error);
        } else if (state is PasswordRecoveryPasswordChanged) {
          context.showCustomSnackBar(
            'Your password has been updated. Sign in with your new password.',
            type: SnackBarType.success,
          );
          context.go(Routes.loginScreen);
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
                            Icons.password_rounded,
                            size: 70,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Set new password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Choose a strong password for your account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hint: 'New password',
                      controller: _newPassController,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hint: 'Confirm password',
                      controller: _confirmPassController,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: 'Save',
                        onPressed: loading
                            ? null
                            : () {
                                final p1 = _newPassController.text;
                                final p2 = _confirmPassController.text;
                                if (p1.length < 6) {
                                  context.showCustomSnackBar(
                                    'Password must be at least 6 characters.',
                                    type: SnackBarType.error,
                                  );
                                  return;
                                }
                                if (p1 != p2) {
                                  context.showCustomSnackBar(
                                    'Passwords do not match.',
                                    type: SnackBarType.error,
                                  );
                                  return;
                                }
                                context.read<PasswordRecoveryCubit>().submitNewPassword(
                                      email: widget.email,
                                      otp: widget.otp,
                                      newPassword: p1,
                                    );
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
