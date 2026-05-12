import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/categories/domain/entities/category.dart';
import 'package:e_commerce_app/features/categories/domain/repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository categoriesRepository;

  GetCategoriesUseCase(this.categoriesRepository);

  Future<Either<Failure, List<Category>>> call() {
    return categoriesRepository.getAllCategories();
  }
}
