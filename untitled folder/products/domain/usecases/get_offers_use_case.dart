import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/offers_pagination.dart';
import '../repositories/offer_repository.dart';

class GetOffersUseCase {
  final OfferRepository offerRepository;

  GetOffersUseCase(this.offerRepository);

  Future<Either<Failure, OffersPagination>> call() {
    return offerRepository.getOffers();
  }
}
