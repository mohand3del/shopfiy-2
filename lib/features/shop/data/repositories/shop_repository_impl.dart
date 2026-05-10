import 'package:dio/dio.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/shop_remote_datasource.dart';
import '../mappers/product_mapper.dart';
import '../../../../core/error/failures.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource _remote;

  const ShopRepositoryImpl(this._remote);

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
      return (null, _mapDio(e));
    } catch (e) {
      return (null, ServerFailure(e.toString()));
    }
  }

  Failure _mapDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timed out. Check your internet.');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection.');
      default:
        final statusCode = e.response?.statusCode;
        final message = _messageFromResponse(e.response?.data, e.message);
        if (statusCode == 401) return UnauthorizedFailure(message);
        if (statusCode == 400 || statusCode == 422) {
          return ValidationFailure(message);
        }
        return ServerFailure(message);
    }
  }

  String _messageFromResponse(dynamic data, String? fallback) {
    if (data is Map<String, dynamic>) {
      final m = data['message']?.toString().trim();
      if (m != null && m.isNotEmpty) return m;
      final d = data['detail']?.toString().trim();
      if (d != null && d.isNotEmpty) return d;
    }
    return fallback ?? 'Something went wrong';
  }
}
