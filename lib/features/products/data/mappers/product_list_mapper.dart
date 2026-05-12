import 'package:practical_cubit/features/products/data/mappers/product_mapper.dart';
import 'package:practical_cubit/features/products/data/models/product_model.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';

extension ProductListMapper on List<ProductModel> {
  List<Product> toEntityList() => map((e) => e.toEntity()).toList();
}
