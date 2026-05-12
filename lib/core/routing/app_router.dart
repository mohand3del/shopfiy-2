import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:practical_cubit/core/di/service_locator.dart';
import 'package:practical_cubit/core/routing/routes.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:practical_cubit/features/auth/presentation/screens/create_account_screen.dart';
import 'package:practical_cubit/features/auth/presentation/screens/login_screen.dart';
import 'package:practical_cubit/features/auth/presentation/screens/start_screen.dart';
import 'package:practical_cubit/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:practical_cubit/features/shop/presentation/cubit/home_cubit.dart';
import 'package:practical_cubit/features/shop/presentation/screens/home_screen.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: Routes.startScreen,
        name: Routes.startScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const StartScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'register',
            name: Routes.registerScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => getIt<AuthCubit>(),
                child: const CreateAccountScreen(),
              );
            },
          ),
          GoRoute(
            path: 'login',
            name: Routes.loginScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => getIt<AuthCubit>(),
                child: const LoginScreen(),
              );
            },
          ),
          GoRoute(
            path: Routes.verifyEmailScreen,
            name: Routes.verifyEmailScreen,
            builder: (BuildContext context, GoRouterState state) {
              final email = state.extra as String? ?? '';
              return BlocProvider(
                create: (context) => getIt<AuthCubit>(),
                child: VerifyEmailScreen(email: email),
              );
            },
          ),
          GoRoute(
            path: Routes.homeScreen,
            name: Routes.homeScreen,
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (context) => getIt<HomeCubit>(),
                child: const HomeScreen(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
