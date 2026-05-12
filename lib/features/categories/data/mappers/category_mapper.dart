import 'package:practical_cubit/features/categories/data/m/category_model.dart';
import 'package:practical_cubit/features/categories/domain/entities/category.dart';

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
