import 'package:dartz/dartz.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Product>> getProductById(String id);
}
