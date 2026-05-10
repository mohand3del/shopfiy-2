


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_cubit/core/di/injection_container.dart';
import 'package:practical_cubit/core/routes/app_routes_constant.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practical_cubit/features/auth/presentation/screens/login_screen.dart';
import 'package:practical_cubit/features/auth/presentation/screens/start_screen.dart';
import 'package:practical_cubit/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:practical_cubit/features/shop/presentation/cubit/home_cubit.dart';
import 'package:practical_cubit/features/shop/presentation/screens/home_screen.dart';

abstract class AppRouter {

 static final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutesConstant.startScreen,
      name: AppRoutesConstant.startScreen,
      builder: (BuildContext context, GoRouterState state) {
        return StartScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          // child paths should be relative when nested under '/'
          path: 'register',
          name: AppRoutesConstant.registerScreen,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: CreateAccountScreen());
          },
        ),
        GoRoute(
          path: 'login',
          name: AppRoutesConstant.loginScreen,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: const LoginScreen(),
            );
          },
        ),
        GoRoute(
          path: AppRoutesConstant.verifyEmailScreen,
          name: AppRoutesConstant.verifyEmailScreen,
          builder: (BuildContext context, GoRouterState state) {
            final email = state.extra as String? ?? '';
            return BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: VerifyEmailScreen(email: email),
            );
          },
        ),
        GoRoute(
          path: AppRoutesConstant.homeScreen,
          name: AppRoutesConstant.homeScreen,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => sl<HomeCubit>(),
              child: const HomeScreen(),
            );
          },
        ),
      ],
    ),
  ],
);
}
