// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersResponseModel _$OffersResponseModelFromJson(Map<String, dynamic> json) =>
    OffersResponseModel(
      offers: OffersDataModel.fromJson(json['offers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffersResponseModelToJson(
  OffersResponseModel instance,
) => <String, dynamic>{'offers': instance.offers};

OffersDataModel _$OffersDataModelFromJson(Map<String, dynamic> json) =>
    OffersDataModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );

Map<String, dynamic> _$OffersDataModelToJson(OffersDataModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
    };
