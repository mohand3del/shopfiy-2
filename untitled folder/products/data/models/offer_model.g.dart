// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  coverUrl: json['coverUrl'] as String,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'coverUrl': instance.coverUrl,
      'createdAt': instance.createdAt,
    };
