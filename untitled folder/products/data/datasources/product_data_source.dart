import 'package:e_commerce_app/features/products/data/models/product_model.dart';
import 'package:e_commerce_app/features/products/data/models/products_response.dart';

abstract class ProductDataSource {
  // as abdo i'am user ♥
  Future<ProductsResponse> getAllProducts(Map<String, dynamic> requestBody);
  Future<ProductModel> getProductById(String id);
  // by admin
  // Future<void> createProduct(Product product);
  // Future<void> updateProduct(Product product);
  // Future<void> deleteProduct(String id);
}
