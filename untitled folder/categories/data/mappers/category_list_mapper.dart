import 'package:e_commerce_app/features/categories/data/m/category_model.dart';
import 'package:e_commerce_app/features/categories/data/mappers/category_mapper.dart';
import 'package:e_commerce_app/features/categories/domain/entities/category.dart';

extension CategoryListMapper on List<CategoryModel> {
  List<Category> toEntityList() => map((e) => e.toEntity()).toList();
}
