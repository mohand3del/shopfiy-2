import 'package:e_commerce_app/features/reviews/data/models/review_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reviews_response.g.dart';

@JsonSerializable()
class ReviewsResponse {
  final List<ReviewModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const ReviewsResponse({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) {
    final reviewsJson = json['reviews'] as Map<String, dynamic>? ?? json;

    return _$ReviewsResponseFromJson(reviewsJson);
  }

  Map<String, dynamic> toJson() => _$ReviewsResponseToJson(this);
}
