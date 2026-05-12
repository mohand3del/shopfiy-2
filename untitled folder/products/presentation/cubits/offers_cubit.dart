import '../../../../core/cubit/async_cubit.dart';
import '../../domain/entities/offers_pagination.dart';
import '../../domain/usecases/get_offers_use_case.dart';

class OffersCubit extends AsyncCubit<OffersPagination> {
  final GetOffersUseCase getOffersUseCase;

  OffersCubit({required this.getOffersUseCase});

  Future<void> fetchOffers() async {
    await executeEither(() => getOffersUseCase());
  }
}
