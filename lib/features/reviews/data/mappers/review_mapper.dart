import '../../domain/entities/review.dart';
import '../models/review_model.dart';

extension ReviewMapper on ReviewModel {
  Review toEntity() {
    return Review(
      comment: comment,
      rating: rating,
      createdAt: DateTime.parse(createdAt),
      userName: userName,
      userPicture: userPicture,
    );
  }
}

extension ReviewListMapper on List<ReviewModel> {
  List<Review> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}
