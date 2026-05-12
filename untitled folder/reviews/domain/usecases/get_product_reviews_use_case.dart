import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/review.dart';
import '../repositories/reviews_repository.dart';

class GetProductReviewsUseCase {
  final ReviewsRepository reviewsRepository;

  GetProductReviewsUseCase(this.reviewsRepository);

  Future<Either<Failure, List<Review>>> call(String productId) {
    return reviewsRepository.getProductReviews(productId);
  }
}
