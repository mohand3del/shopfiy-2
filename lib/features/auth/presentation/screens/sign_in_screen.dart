// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/auth_cubit.dart';
// import '../cubit/auth_state.dart';
// import '../widgets/custom_text_field.dart';
// import 'sign_up_screen.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   void _onSignIn(BuildContext context) {
//     if (!_formKey.currentState!.validate()) return;
//
//     context.read<AuthCubit>().signIn(
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is AuthSuccess) {
//             // ✅ Navigate to home on success
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Welcome back, ${state.user.name}!'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//             // TODO: Navigator.pushReplacementNamed(context, '/home');
//           }
//
//           if (state is AuthFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // ─── Header ──────────────────────────────────────────
//                     const SizedBox(height: 40),
//                     Icon(
//                       Icons.lock_outline_rounded,
//                       size: 64,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       'Welcome Back',
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Sign in to your account',
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             color: Colors.grey,
//                           ),
//                     ),
//
//                     // ─── Form ─────────────────────────────────────────────
//                     const SizedBox(height: 40),
//                     AuthTextField(
//                       label: 'Email',
//                       hint: 'you@example.com',
//                       controller: _emailController,
//                       prefixIcon: Icons.email_outlined,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
//                             .hasMatch(value)) {
//                           return 'Enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     AuthTextField(
//                       label: 'Password',
//                       hint: '••••••••',
//                       controller: _passwordController,
//                       prefixIcon: Icons.lock_outlined,
//                       isPassword: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     // ─── Sign In Button ───────────────────────────────────
//                     const SizedBox(height: 32),
//                     SizedBox(
//                       height: 52,
//                       child: ElevatedButton(
//                         onPressed: state is AuthLoading
//                             ? null
//                             : () => _onSignIn(context),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: state is AuthLoading
//                             ? const SizedBox(
//                                 width: 24,
//                                 height: 24,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   color: Colors.white,
//                                 ),
//                               )
//                             : const Text(
//                                 'Sign In',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                       ),
//                     ),
//
//                     // ─── Navigate to Sign Up ──────────────────────────────
//                     const SizedBox(height: 24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account?"),
//                         TextButton(
//                           onPressed: () {
//                             context.read<AuthCubit>().reset();
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => BlocProvider.value(
//                                   value: context.read<AuthCubit>(),
//                                   child: const SignUpScreen(),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: const Text('Sign Up'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
