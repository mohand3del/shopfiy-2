import 'package:e_commerce_app/core/cubit/async_cubit.dart';
import 'package:e_commerce_app/features/categories/domain/entities/category.dart';
import 'package:e_commerce_app/features/categories/domain/usecases/get_categories_use_case.dart';

class CategoriesCubit extends AsyncCubit<List<Category>> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesCubit({required this.getCategoriesUseCase});

  Future<void> fetchAllCategories() async {
    await executeEither(() => getCategoriesUseCase());
  }
}
