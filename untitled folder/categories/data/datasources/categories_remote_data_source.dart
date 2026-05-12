import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constant/api_endpoints.dart';
import 'package:e_commerce_app/features/categories/data/datasources/categories_data_source.dart';
import 'package:e_commerce_app/features/categories/data/m/categories_response.dart';
import 'package:e_commerce_app/features/categories/data/m/category_model.dart';
import 'package:retrofit/retrofit.dart';

part 'categories_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class CategoriesRemoteDataSource implements CategoriesDataSource {
  factory CategoriesRemoteDataSource(Dio dio, {String baseUrl}) =
      _CategoriesRemoteDataSource;

  @GET(ApiEndpoints.categories)
  @override
  Future<CategoriesResponse> getAllCategories();

  @GET("${ApiEndpoints.categories}/{id}")
  @override
  Future<CategoryModel> getCategoryById(@Path("id") String categoryId);
}
