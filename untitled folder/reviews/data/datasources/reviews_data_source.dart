import 'package:e_commerce_app/features/reviews/data/models/reviews_response.dart';

import '../models/review_model.dart';

abstract class ReviewsDataSource {
  Future<ReviewsResponse> getProductReviews(String productId);
}
