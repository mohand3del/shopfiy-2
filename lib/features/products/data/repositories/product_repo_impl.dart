import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:practical_cubit/core/di/service_locator.dart';
import 'package:practical_cubit/core/errors/dio_error_handler.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import 'package:practical_cubit/features/products/data/datasources/product_data_source.dart';
import 'package:practical_cubit/features/products/data/mappers/product_list_mapper.dart';
import 'package:practical_cubit/features/products/data/mappers/product_mapper.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:practical_cubit/features/products/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductsRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl({required this.productDataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final response = await productDataSource.getAllProducts({
        "page": 1,
        "pageSize": 18,
      });
      final products = response.items;
      final productEntities = products.toEntityList();
      return Right(productEntities);
    } on DioException catch (e) {
      return Left(getIt<DioErrorHandler>().handle(e));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final product = await productDataSource.getProductById(id);
      final productEntity = product.toEntity();
      return Right(productEntity);
    } on DioException catch (e) {
      return Left(getIt<DioErrorHandler>().handle(e));
    }
  }
}
