import 'package:dartz/dartz.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/categories/domain/entities/category.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
  Future<Either<Failure, Category>> getCategoryById(String categoryId);
}
