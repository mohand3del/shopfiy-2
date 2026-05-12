import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/errors/dio_error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/offers_pagination.dart';
import '../../domain/repositories/offer_repository.dart';
import '../datasources/offer_remote_data_source.dart';
import '../mappers/offer_mapper.dart';

class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteDataSource offerRemoteDataSource;

  OfferRepositoryImpl({required this.offerRemoteDataSource});

  @override
  Future<Either<Failure, OffersPagination>> getOffers() async {
    try {
      final offersResponse = await offerRemoteDataSource.getOffers({
        "page": 1,
        "pageSize": 18,
      });
      final offersPagination = offersResponse.toEntity();
      return Right(offersPagination);
    } on DioException catch (e) {
      return Left(getIt<DioErrorHandler>().handle(e));
    }
  }
}
