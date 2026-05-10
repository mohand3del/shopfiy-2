import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/request_password_reset_usecase.dart';
import '../../features/auth/domain/usecases/resend_otp_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/sign_in_usecase.dart';
import '../../features/auth/domain/usecases/sign_up_usecase.dart';
import '../../features/auth/domain/usecases/validate_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_email_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> setupDependencies() async {
  // ─── Core ──────────────────────────────────────────────
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // ─── Data Sources ──────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>().dio),
  );

  // ─── Repositories ──────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()),
  );

  // ─── Use Cases ─────────────────────────────────────────
  sl.registerLazySingleton(() => SignInUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ValidateOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(
    () => RequestPasswordResetUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton(() => ResendOtpUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl<AuthRepository>()));

  // ─── Cubits (factory = new instance each time) ─────────
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      signInUseCase: sl<SignInUseCase>(),
      signUpUseCase: sl<SignUpUseCase>(),
      verifyEmailUseCase: sl<VerifyEmailUseCase>(),
      validateOtpUseCase: sl<ValidateOtpUseCase>(),
    ),
  );

  /// [PasswordRecoveryCubit] is created at navigation time (see
  /// [openPasswordRecoveryFlow]) so the widget layer does not depend on a
  /// separate GetIt factory registration for that type.
}
