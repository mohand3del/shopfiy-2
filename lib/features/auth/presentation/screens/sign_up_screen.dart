// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/auth_cubit.dart';
// import '../cubit/auth_state.dart';
// import '../widgets/custom_text_field.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _onSignUp(BuildContext context) {
//     if (!_formKey.currentState!.validate()) return;
//
//     context.read<AuthCubit>().signUp(
//           firstName: _firstNameController.text.trim(),
//           lastName: _lastNameController.text.trim(),
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is AuthSuccess) {
//             // ✅ Navigate to home after register
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Account created! Welcome, ${state.user.name}!'),
//                 backgroundColor: Colors.green,
//               ),
//             );
//             // TODO: Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
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
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // ─── Header ──────────────────────────────────────────
//                     Icon(
//                       Icons.person_add_outlined,
//                       size: 64,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Create Account',
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Fill in your details to get started',
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             color: Colors.grey,
//                           ),
//                     ),
//
//                     // ─── Form Fields ──────────────────────────────────────
//                     const SizedBox(height: 32),
//                     AuthTextField(
//                       label: 'First Name',
//                       hint: 'John',
//                       controller: _firstNameController,
//                       prefixIcon: Icons.person_outlined,
//                       validator: (value) {
//                         final text = value?.trim() ?? '';
//                         if (text.isEmpty) {
//                           return 'First name is required';
//                         }
//                         if (text.length < 3) {
//                           return 'First name must be at least 3 characters';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     AuthTextField(
//                       label: 'Last Name',
//                       hint: 'Doe',
//                       controller: _lastNameController,
//                       prefixIcon: Icons.person_outline,
//                       validator: (value) {
//                         final text = value?.trim() ?? '';
//                         if (text.isEmpty) {
//                           return 'Last name is required';
//                         }
//                         if (text.length < 3) {
//                           return 'Last name must be at least 3 characters';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
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
//                         final text = value ?? '';
//                         if (text.isEmpty) {
//                           return 'Password is required';
//                         }
//                         if (text.length < 8) {
//                           return 'Password must be at least 8 characters';
//                         }
//                         if (!RegExp(r'[A-Z]').hasMatch(text)) {
//                           return 'Password must contain at least one uppercase letter';
//                         }
//                         if (!RegExp(r'[a-z]').hasMatch(text)) {
//                           return 'Password must contain at least one lowercase letter';
//                         }
//                         if (!RegExp(r'[0-9]').hasMatch(text)) {
//                           return 'Password must contain at least one digit';
//                         }
//                         if (!RegExp(r'[^A-Za-z0-9]').hasMatch(text)) {
//                           return 'Password must contain at least one special character';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     AuthTextField(
//                       label: 'Confirm Password',
//                       hint: '••••••••',
//                       controller: _confirmPasswordController,
//                       prefixIcon: Icons.lock_outlined,
//                       isPassword: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please confirm your password';
//                         }
//                         if (value != _passwordController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     // ─── Sign Up Button ───────────────────────────────────
//                     const SizedBox(height: 32),
//                     SizedBox(
//                       height: 52,
//                       child: ElevatedButton(
//                         onPressed: state is AuthLoading
//                             ? null
//                             : () => _onSignUp(context),
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
//                                 'Create Account',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                       ),
//                     ),
//
//                     // ─── Navigate back to Sign In ─────────────────────────
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text('Already have an account?'),
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text('Sign In'),
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
