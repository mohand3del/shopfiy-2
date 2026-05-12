import 'package:dartz/dartz.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:practical_cubit/features/products/domain/repositories/product_repo.dart';

class GetProductsUseCase {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call() {
    return repository.getAllProducts();
  }
}
