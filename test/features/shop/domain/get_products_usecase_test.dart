import 'package:flutter_test/flutter_test.dart';
import 'package:practical_cubit/core/error/failures.dart';
import 'package:practical_cubit/features/shop/domain/entities/product_entity.dart';
import 'package:practical_cubit/features/shop/domain/repositories/shop_repository.dart';
import 'package:practical_cubit/features/shop/domain/usecases/get_products_usecase.dart';

class _FakeShopRepo implements ShopRepository {
  _FakeShopRepo({required this.result});

  final (List<ProductEntity>?, Failure?) result;

  @override
  Future<(List<ProductEntity>?, Failure?)> getProducts({
    required int page,
    required int pageSize,
    String? searchTerm,
  }) async =>
      result;
}

void main() {
  test('forwards page and pageSize to repository', () async {
    final repo = _FakeShopRepo(
      result: (
        [
          const ProductEntity(
            id: '1',
            name: 'Test',
            coverPictureUrl: 'https://example.com/a.png',
            price: 10,
          ),
        ],
        null,
      ),
    );
    final useCase = GetProductsUseCase(repo);

    final out = await useCase(page: 2, pageSize: 10);

    expect(out.$1?.length, 1);
    expect(out.$1?.first.name, 'Test');
    expect(out.$2, isNull);
  });
}
