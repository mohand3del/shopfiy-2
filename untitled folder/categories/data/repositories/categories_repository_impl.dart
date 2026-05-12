import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/dio_error_handler.dart';
import 'package:e_commerce_app/features/categories/data/datasources/categories_data_source.dart';
import 'package:e_commerce_app/features/categories/data/mappers/category_list_mapper.dart';
import 'package:e_commerce_app/features/categories/data/mappers/category_mapper.dart';
import 'package:e_commerce_app/features/categories/domain/entities/category.dart';
import 'package:e_commerce_app/features/categories/domain/repositories/categories_repository.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/errors/failure.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesDataSource categoriesDataSource;

  CategoriesRepositoryImpl({required this.categoriesDataSource});

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final response = await categoriesDataSource.getAllCategories();
      final categories = response.categories;
      final categoryEntities = categories.toEntityList();
      return Right(categoryEntities);
    } on DioException catch (e) {
      return Left(getIt<DioErrorHandler>().handle(e));
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String categoryId) async {
    try {
      final category = await categoriesDataSource.getCategoryById(categoryId);

      final categoryEntity = category.toEntity();
      return Right(categoryEntity);
    } on DioException catch (e) {
      return Left(getIt<DioErrorHandler>().handle(e));
    }
  }
}
