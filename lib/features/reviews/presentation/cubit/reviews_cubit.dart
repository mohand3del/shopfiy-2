import '../../../../core/cubit/async_cubit.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/get_product_reviews_use_case.dart';

class ReviewsCubit extends AsyncCubit<List<Review>> {
  final GetProductReviewsUseCase getProductReviewsUseCase;

  ReviewsCubit({required this.getProductReviewsUseCase});

  Future<void> fetchProductReviews(String productId) async {
    await executeEither(() => getProductReviewsUseCase(productId));
  }
}
