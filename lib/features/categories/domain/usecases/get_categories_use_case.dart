import 'package:dartz/dartz.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/categories/domain/entities/category.dart';
import 'package:practical_cubit/features/categories/domain/repositories/categories_repository.dart';

class GetCategoriesUseCase {
  final CategoriesRepository categoriesRepository;

  GetCategoriesUseCase(this.categoriesRepository);

  Future<Either<Failure, List<Category>>> call() {
    return categoriesRepository.getAllCategories();
  }
}
