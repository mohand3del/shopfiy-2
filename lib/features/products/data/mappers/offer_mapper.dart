import '../../domain/entities/offer.dart';
import '../../domain/entities/offers_pagination.dart';
import '../models/offer_model.dart';
import '../models/offers_response_model.dart';

extension OfferMapper on OfferModel {
  Offer toEntity() {
    return Offer(
      id: id,
      name: name,
      description: description,
      coverUrl: coverUrl,
      createdAt: DateTime.parse(createdAt),
    );
  }
}

extension OfferListMapper on List<OfferModel> {
  List<Offer> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}

extension OffersResponseMapper on OffersResponseModel {
  OffersPagination toEntity() {
    return OffersPagination(
      items: offers.items.toEntities(),
      page: offers.page,
      pageSize: offers.pageSize,
      totalCount: offers.totalCount,
      hasNextPage: offers.hasNextPage,
      hasPreviousPage: offers.hasPreviousPage,
    );
  }
}
