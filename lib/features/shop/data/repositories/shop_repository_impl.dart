import 'package:dio/dio.dart';
import 'package:practical_cubit/core/errors/dio_error_handler.dart';
import 'package:practical_cubit/core/errors/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/shop_remote_datasource.dart';
import '../mappers/product_mapper.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource _remote;
  final DioErrorHandler _dioErrorHandler;

  const ShopRepositoryImpl(this._remote, this._dioErrorHandler);

  @override
  Future<(List<ProductEntity>?, Failure?)> getProducts({
    required int page,
    required int pageSize,
    String? searchTerm,
  }) async {
    try {
      final models = await _remote.listProducts(
        page: page,
        pageSize: pageSize,
        searchTerm: searchTerm,
      );
      final entities =
          models.map(ProductMapper.toEntity).toList(growable: false);
      return (entities, null);
    } on DioException catch (e) {
      return (null, _dioErrorHandler.handle(e));
    } catch (e) {
      return (null, _dioErrorHandler.handle(e));
    }
  }
}
