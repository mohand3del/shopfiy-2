import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final String comment;
  final int rating;
  final String createdAt;
  final String userName;
  final String? userPicture;

  const ReviewModel({
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.userName,
    this.userPicture,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);

}

