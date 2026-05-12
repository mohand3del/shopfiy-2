import 'package:json_annotation/json_annotation.dart';

import 'offer_model.dart';

part 'offers_response_model.g.dart';

@JsonSerializable()
class OffersResponseModel {
  final OffersDataModel offers;

  const OffersResponseModel({required this.offers});

  factory OffersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OffersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OffersResponseModelToJson(this);
}

@JsonSerializable()
class OffersDataModel {
  final List<OfferModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const OffersDataModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory OffersDataModel.fromJson(Map<String, dynamic> json) =>
      _$OffersDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OffersDataModelToJson(this);
}
