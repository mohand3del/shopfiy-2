import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_cubit/core/enums/snack_bar_type.dart';
import 'package:practical_cubit/core/extensions/show_snack_bar_extension.dart';
import 'package:practical_cubit/core/routing/routes.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_state.dart';
import 'package:practical_cubit/features/auth/presentation/screens/password_recovery_screen.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _onLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      context.showCustomSnackBar(
        'Please enter email and password.',
        type: SnackBarType.error,
      );
      return;
    }
    context.read<AuthCubit>().signIn(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.showCustomSnackBar(
            'Welcome back, ${state.user.name}!',
            type: SnackBarType.success,
          );
          context.goNamed(Routes.homeScreen);
        } else if (state is AuthFailure) {
          context.showCustomSnackBar(state.message, type: SnackBarType.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox.expand(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/bg_login.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 380),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff202020),
                            height: 1.1,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Text(
                              'Good to see you back! ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Icon(Icons.favorite, size: 20),
                          ],
                        ),
                        const SizedBox(height: 30),

                        CustomTextField(
                          hint: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          hint: 'Password',
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        const SizedBox(height: 6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () => openPasswordRecoveryFlow(context),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Color(0xff004CFF)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            text: 'Next',
                            onPressed: isLoading ? null : _onLogin,
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
                ),
                if (isLoading)
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
          ),
        );
      },
    );
  }
}
