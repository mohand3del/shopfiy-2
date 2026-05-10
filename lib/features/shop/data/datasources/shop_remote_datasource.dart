import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class ShopRemoteDataSource {
  /// GET `/api/products` — OpenAPI [ListAllProductsRequest] fields as query params.
  Future<List<ProductModel>> listProducts({
    required int page,
    required int pageSize,
    String? searchTerm,
  });
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  final Dio _dio;

  const ShopRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ProductModel>> listProducts({
    required int page,
    required int pageSize,
    String? searchTerm,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/products',
      queryParameters: <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
        if (searchTerm != null && searchTerm.trim().isNotEmpty)
          'searchTerm': searchTerm.trim(),
      },
    );

    final root = _asJsonMap(response.data);
    final rawItems = root['items'];
    if (rawItems is! List) return [];

    return rawItems
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();
  }

  Map<String, dynamic> _asJsonMap(dynamic raw) {
    if (raw is! Map<String, dynamic>) return <String, dynamic>{};
    final data = raw['data'];
    if (data is Map<String, dynamic>) return data;
    return raw;
  }
}
