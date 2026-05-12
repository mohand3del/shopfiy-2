import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  final String id;
  final String name;
  final String description;
  final String coverUrl;
  final String createdAt;

  const OfferModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
    required this.createdAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
