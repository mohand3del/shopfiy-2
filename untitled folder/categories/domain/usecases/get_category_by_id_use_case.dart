import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/categories/domain/entities/category.dart';
import 'package:e_commerce_app/features/categories/domain/repositories/categories_repository.dart';

class GetCategoryByIdUseCase {
  final CategoriesRepository categoriesRepository;
  GetCategoryByIdUseCase(this.categoriesRepository);
  Future<Either<Failure, Category>> call(String categoryId) {
    return categoriesRepository.getCategoryById(categoryId);
  }
}
