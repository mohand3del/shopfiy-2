// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
  comment: json['comment'] as String,
  rating: (json['rating'] as num).toInt(),
  createdAt: json['createdAt'] as String,
  userName: json['userName'] as String,
  userPicture: json['userPicture'] as String?,
);

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'rating': instance.rating,
      'createdAt': instance.createdAt,
      'userName': instance.userName,
      'userPicture': instance.userPicture,
    };
