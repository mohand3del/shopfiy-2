import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';

abstract class ShopRepository {
  /// GET `/api/products` — query matches [ListAllProductsRequest] (page, pageSize, …).
  Future<(List<ProductEntity>?, Failure?)> getProducts({
    required int page,
    required int pageSize,
    String? searchTerm,
  });
}
