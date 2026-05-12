import 'package:practical_cubit/core/cubit/async_cubit.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:practical_cubit/features/products/domain/usecases/get_product_by_id_use_case.dart';

class ProductDetailsCubit extends AsyncCubit<Product> {
  final GetProductByIdUseCase getProductByIdUseCase;

  ProductDetailsCubit(this.getProductByIdUseCase);

  Future<void> fetchProductById(String productId) async {
    await executeEither(() => getProductByIdUseCase(productId));
  }
}
