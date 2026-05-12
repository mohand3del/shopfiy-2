import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/reviews/data/models/reviews_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constant/api_endpoints.dart';
import '../models/review_model.dart';
import 'reviews_data_source.dart';

part 'reviews_remote_data_source.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class ReviewsRemoteDataSource implements ReviewsDataSource {
  factory ReviewsRemoteDataSource(Dio dio, {String baseUrl}) =
      _ReviewsRemoteDataSource;

  @GET("${ApiEndpoints.reviews}/{productId}")
  @override
  Future<ReviewsResponse> getProductReviews(
    @Path("productId") String productId,
  );
}
