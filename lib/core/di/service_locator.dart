import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:practical_cubit/core/api/api_interceptors.dart';
import 'package:practical_cubit/core/api/dio_module.dart';
import 'package:practical_cubit/core/errors/dio_error_handler.dart';
import 'package:practical_cubit/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:practical_cubit/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:practical_cubit/features/auth/domain/repositories/auth_repository.dart';
import 'package:practical_cubit/features/auth/domain/usecases/request_password_reset_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/validate_otp_usecase.dart';
import 'package:practical_cubit/features/auth/domain/usecases/verify_email_usecase.dart';
import 'package:practical_cubit/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:practical_cubit/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:practical_cubit/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:practical_cubit/features/shop/domain/repositories/shop_repository.dart';
import 'package:practical_cubit/features/shop/domain/usecases/get_products_usecase.dart';
import 'package:practical_cubit/features/shop/presentation/cubit/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerFactoryParam<ApiInterceptor, String?, void>((token, _) {
    return ApiInterceptor(token);
  });

  getIt.registerLazySingleton<DioErrorHandler>(() => DioErrorHandler());
  getIt.registerLazySingleton<Dio>(
    () => DioModule(getIt<ApiInterceptor>(param1: null)).dioInstance,
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<DioErrorHandler>(),
    ),
  );

  getIt.registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(
      getIt<ShopRemoteDataSource>(),
      getIt<DioErrorHandler>(),
    ),
  );

  getIt.registerLazySingleton(() => SignInUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => VerifyEmailUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ValidateOtpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
    () => RequestPasswordResetUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton(() => ResendOtpUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetProductsUseCase(getIt<ShopRepository>()));

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      signInUseCase: getIt<SignInUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
      verifyEmailUseCase: getIt<VerifyEmailUseCase>(),
      validateOtpUseCase: getIt<ValidateOtpUseCase>(),
      resendOtpUseCase: getIt<ResendOtpUseCase>(),
    ),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getProductsUseCase: getIt<GetProductsUseCase>()),
  );
}
