import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/offers_pagination.dart';

abstract class OfferRepository {
  Future<Either<Failure, OffersPagination>> getOffers();
}
