import '../../domain/entities/product.dart';
import '../models/product_model.dart';

extension ProductMapper on ProductModel {
  Product toEntity() {
    return Product(
      id: id,
      productCode: productCode,
      name: name,
      description: description,
      arabicName: arabicName,
      arabicDescription: arabicDescription,
      coverPictureUrl: coverPictureUrl,
      productPictures: productPictures ?? [],
      price: price,
      stock: stock,
      color: color,
      rating: rating,
      reviewsCount: reviewsCount,
      discountPercentage: discountPercentage,
      categories: categories,
    );
  }
}
