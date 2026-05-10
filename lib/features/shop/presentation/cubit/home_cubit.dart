import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_products_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUseCase _getProductsUseCase;

  HomeCubit({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase,
        super(const HomeInitial());

  Future<void> loadProducts() async {
    emit(const HomeLoading());

    final (products, failure) = await _getProductsUseCase(
      page: 1,
      pageSize: 24,
    );

    if (failure != null) {
      emit(HomeFailure(failure.message));
      return;
    }

    emit(HomeLoaded(products ?? []));
  }

  Future<void> refresh() => loadProducts();
}
