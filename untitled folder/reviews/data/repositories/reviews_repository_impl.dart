import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/reviews_repository.dart';
import '../datasources/reviews_data_source.dart';
import '../mappers/review_mapper.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsDataSource reviewsDataSource;

  ReviewsRepositoryImpl({required this.reviewsDataSource});

  @override
  Future<Either<Failure, List<Review>>> getProductReviews(
    String productId,
  ) async {
    try {
      final response = await reviewsDataSource.getProductReviews(productId);
      final reviews = response.items;
      final reviewEntities = reviews.toEntities();
      return Right(reviewEntities);
    } on DioException catch (e) {
      return Left(getIt<DioErrorHandler>().handle(e));
    }
  }
}
