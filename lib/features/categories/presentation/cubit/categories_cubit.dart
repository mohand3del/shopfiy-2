import 'package:practical_cubit/core/cubit/async_cubit.dart';
import 'package:practical_cubit/features/categories/domain/entities/category.dart';
import 'package:practical_cubit/features/categories/domain/usecases/get_categories_use_case.dart';

class CategoriesCubit extends AsyncCubit<List<Category>> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesCubit({required this.getCategoriesUseCase});

  Future<void> fetchAllCategories() async {
    await executeEither(() => getCategoriesUseCase());
  }
}
