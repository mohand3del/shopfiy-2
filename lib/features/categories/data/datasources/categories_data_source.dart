import 'package:practical_cubit/features/categories/data/m/categories_response.dart';
import 'package:practical_cubit/features/categories/data/m/category_model.dart';

abstract class CategoriesDataSource {
Future<CategoriesResponse> getAllCategories();
  Future<CategoryModel> getCategoryById(String categoryId);
}
