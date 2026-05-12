import 'package:dartz/dartz.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/categories/domain/entities/category.dart';
import 'package:practical_cubit/features/categories/domain/repositories/categories_repository.dart';

class GetCategoryByIdUseCase {
  final CategoriesRepository categoriesRepository;
  GetCategoryByIdUseCase(this.categoriesRepository);
  Future<Either<Failure, Category>> call(String categoryId) {
    return categoriesRepository.getCategoryById(categoryId);
  }
}
