import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';

class ProductMapper {
  static ProductEntity toEntity(ProductModel m) {
    return ProductEntity(
      id: m.id,
      name: m.name,
      coverPictureUrl: m.coverPictureUrl,
      price: m.price,
      discountPercentage: m.discountPercentage,
      stock: m.stock,
    );
  }
}
