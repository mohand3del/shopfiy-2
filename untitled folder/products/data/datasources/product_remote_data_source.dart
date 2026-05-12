import 'package:e_commerce_app/core/constant/api_endpoints.dart';
import 'package:e_commerce_app/features/products/data/datasources/product_data_source.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';
import 'package:e_commerce_app/features/products/data/models/products_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
part 'product_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ProductRemoteDataSource implements ProductDataSource {
  factory ProductRemoteDataSource(Dio dio, {String baseUrl}) =
      _ProductRemoteDataSource;
  @override
  @GET(ApiEndpoints.products)
  @Headers({
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1YjNlNDA0Zi1mNTBmLTRmODYtZjIwMy0wOGRlMDdjM2ZlMTMiLCJqdGkiOiJlMzI2NzNiOC01ZTQ2LTQ1YzEtOTlkNy1lNzM4MWY4ZmZlNDAiLCJlbWFpbCI6Im1lZGFmZTkzOTVAYXJxc2lzLmNvbSIsIm5hbWUiOiJNb2hhbWVkIFJhc2hhZCIsInJvbGVzIjoiIiwicGljdHVyZSI6IiIsImV4cCI6MTc2MDQwMDUwNywiaXNzIjoiZXNob3AubmV0IiwiYXVkIjoiZXNob3AubmV0In0.LNNoybBu3yv5woQ1pRWKrpCoH-Be4-KF4DuetpBunFM',
    'Content-Type': 'application/json',
  })
  Future<ProductsResponse> getAllProducts(
    @Body() Map<String, dynamic> requestBody,
  );

  @override
  @GET('${ApiEndpoints.products}/{id}')
  Future<ProductModel> getProductById(@Path('id') String id);
  // @override
  // @POST(ApiEndpoints.products)
  // Future<void> createProduct(@Body() Product product);

  // @override
  // @PUT('${ApiEndpoints.products}/{id}')
  // Future<void> updateProduct(@Path('id') String id, @Body() Product product);

  // @override
  // @DELETE('${ApiEndpoints.products}/{id}')
  // Future<void> deleteProduct(@Path('id') String id);
}
