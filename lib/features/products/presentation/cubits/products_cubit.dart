import 'package:practical_cubit/core/cubit/async_cubit.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:practical_cubit/features/products/domain/usecases/get_products_use_case.dart';

class ProductsCubit extends AsyncCubit<List<Product>> {
  final GetProductsUseCase getProductsUseCase;

  ProductsCubit(this.getProductsUseCase);

  Future<void> fetchAllProducts() async {
    await executeEither(() => getProductsUseCase());
    // this like executeEither(() async => await getProductsUseCase.call()); By Abdo ☻☻☻
  }
}
