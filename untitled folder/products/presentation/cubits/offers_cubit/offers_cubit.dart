import 'package:e_commerce_app/core/cubit/async_cubit.dart';
import 'package:e_commerce_app/features/products/domain/usecases/get_offers_use_case.dart';

import '../../../domain/entities/offers_pagination.dart';

class OffersCubit extends AsyncCubit<OffersPagination> {
  final GetOffersUseCase getOffersUseCase;

  OffersCubit({required this.getOffersUseCase});

  Future<void> fetchOffers() async {
    await executeEither(() => getOffersUseCase());
  }
}
