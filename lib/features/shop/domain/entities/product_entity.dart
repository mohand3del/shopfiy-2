import 'package:equatable/equatable.dart';

/// Product row for listings — mapped from API [ProductDto].
class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String coverPictureUrl;
  final double price;
  final int discountPercentage;
  final int stock;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.coverPictureUrl,
    required this.price,
    this.discountPercentage = 0,
    this.stock = 0,
  });

  @override
  List<Object?> get props =>
      [id, name, coverPictureUrl, price, discountPercentage, stock];
}
