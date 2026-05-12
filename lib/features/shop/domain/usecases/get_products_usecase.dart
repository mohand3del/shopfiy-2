import 'package:practical_cubit/core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/shop_repository.dart';

class GetProductsUseCase {
  final ShopRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<(List<ProductEntity>?, Failure?)> call({
    int page = 1,
    int pageSize = 20,
    String? searchTerm,
  }) {
    return _repository.getProducts(
      page: page,
      pageSize: pageSize,
      searchTerm: searchTerm,
    );
  }
}
