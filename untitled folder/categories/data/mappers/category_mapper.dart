import 'package:e_commerce_app/features/categories/data/m/category_model.dart';
import 'package:e_commerce_app/features/categories/domain/entities/category.dart';

extension CategoryMapper on CategoryModel {
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      description: description,
      coverPictureUrl: coverPictureUrl,
    );
  }
}
