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
import 'package:practical_cubit/features/categories/data/datasources/categories_data_source.dart';
import 'package:practical_cubit/features/categories/data/datasources/categories_remote_data_source.dart';
import 'package:practical_cubit/features/categories/data/repositories/categories_repository_impl.dart';
import 'package:practical_cubit/features/categories/domain/repositories/categories_repository.dart';
import 'package:practical_cubit/features/categories/domain/usecases/get_categories_use_case.dart';
import 'package:practical_cubit/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:practical_cubit/features/products/data/datasources/offer_remote_data_source.dart';
import 'package:practical_cubit/features/products/data/datasources/product_data_source.dart';
import 'package:practical_cubit/features/products/data/datasources/product_remote_data_source.dart';
import 'package:practical_cubit/features/products/data/repositories/offer_repository_impl.dart';
import 'package:practical_cubit/features/products/data/repositories/product_repo_impl.dart';
import 'package:practical_cubit/features/products/domain/repositories/offer_repository.dart';
import 'package:practical_cubit/features/products/domain/repositories/product_repo.dart';
import 'package:practical_cubit/features/products/domain/usecases/get_offers_use_case.dart';
import 'package:practical_cubit/features/products/domain/usecases/get_product_by_id_use_case.dart';
import 'package:practical_cubit/features/products/domain/usecases/get_products_use_case.dart';
import 'package:practical_cubit/features/products/presentation/cubits/offers_cubit.dart';
import 'package:practical_cubit/features/products/presentation/cubits/product_details_cubit.dart';
import 'package:practical_cubit/features/products/presentation/cubits/products_cubit.dart';
import 'package:practical_cubit/features/reviews/data/datasources/reviews_data_source.dart';
import 'package:practical_cubit/features/reviews/data/datasources/reviews_remote_data_source.dart';
import 'package:practical_cubit/features/reviews/data/repositories/reviews_repository_impl.dart';
import 'package:practical_cubit/features/reviews/domain/repositories/reviews_repository.dart';
import 'package:practical_cubit/features/reviews/domain/usecases/get_product_reviews_use_case.dart';
import 'package:practical_cubit/features/reviews/presentation/cubit/reviews_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerFactoryParam<ApiInterceptor, String?, void>((token, _) {
    return ApiInterceptor(token);
  });

  getIt.registerLazySingleton<DioErrorHandler>(() => DioErrorHandler());
  getIt.registerLazySingleton<Dio>(
    () => DioModule(getIt<ApiInterceptor>(param1: null)).dioInstance,
  );

  _setupAuthDependencies();
  _setupReviewsDependencies();
  _setupCategoriesDependencies();
  _setupProductsDependencies();
  _setupOffersDependencies();
}

void _setupAuthDependencies() {
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
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

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      signInUseCase: getIt<SignInUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
      verifyEmailUseCase: getIt<VerifyEmailUseCase>(),
      validateOtpUseCase: getIt<ValidateOtpUseCase>(),
      resendOtpUseCase: getIt<ResendOtpUseCase>(),
    ),
  );
}

void _setupReviewsDependencies() {
  getIt.registerLazySingleton<ReviewsDataSource>(
    () => ReviewsRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ReviewsRepository>(
    () => ReviewsRepositoryImpl(reviewsDataSource: getIt<ReviewsDataSource>()),
  );

  getIt.registerLazySingleton<GetProductReviewsUseCase>(
    () => GetProductReviewsUseCase(getIt<ReviewsRepository>()),
  );

  getIt.registerFactory<ReviewsCubit>(
    () => ReviewsCubit(
      getProductReviewsUseCase: getIt<GetProductReviewsUseCase>(),
    ),
  );
}

void _setupCategoriesDependencies() {
  getIt.registerLazySingleton<CategoriesDataSource>(
    () => CategoriesRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      categoriesDataSource: getIt<CategoriesDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<CategoriesRepository>()),
  );

  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(getCategoriesUseCase: getIt<GetCategoriesUseCase>()),
  );
}

void _setupProductsDependencies() {
  getIt.registerLazySingleton<ProductDataSource>(
    () => ProductRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductRepositoryImpl(productDataSource: getIt<ProductDataSource>()),
  );

  getIt.registerLazySingleton<GetProductsUseCase>(
    () => GetProductsUseCase(getIt<ProductsRepository>()),
  );

  getIt.registerLazySingleton<GetProductByIdUseCase>(
    () => GetProductByIdUseCase(getIt<ProductsRepository>()),
  );

  getIt.registerLazySingleton<ProductsCubit>(
    () => ProductsCubit(getIt<GetProductsUseCase>()),
  );

  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(getIt<GetProductByIdUseCase>()),
  );
}

void _setupOffersDependencies() {
  getIt.registerLazySingleton<OfferRemoteDataSource>(
    () => OfferRemoteDataSource(getIt<Dio>()),
  );

  getIt.registerLazySingleton<OfferRepository>(
    () => OfferRepositoryImpl(
      offerRemoteDataSource: getIt<OfferRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetOffersUseCase>(
    () => GetOffersUseCase(getIt<OfferRepository>()),
  );

  getIt.registerFactory<OffersCubit>(
    () => OffersCubit(getOffersUseCase: getIt<GetOffersUseCase>()),
  );
}
