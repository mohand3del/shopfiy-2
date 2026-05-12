import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/review.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, List<Review>>> getProductReviews(String productId);
}
