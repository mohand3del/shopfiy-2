import 'package:e_commerce_app/features/categories/data/m/category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  final List<CategoryModel> categories;

  const CategoriesResponse({required this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);
}
