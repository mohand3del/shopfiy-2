import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final String coverPictureUrl;
  final List<String>? productPictures;
  final double price;
  final int stock;
  final String color;
  final int rating;
  final int reviewsCount;
  final double discountPercentage;
  final List<String> categories;

  const Product({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    required this.arabicName,
    required this.arabicDescription,
    required this.coverPictureUrl,
    required this.productPictures,
    required this.price,
    required this.stock,
    required this.color,
    required this.rating,
    required this.reviewsCount,
    required this.discountPercentage,
    required this.categories,
  });

  @override
  List<Object?> get props => [
        id,
        productCode,
        name,
        description,
        arabicName,
        arabicDescription,
        coverPictureUrl,
        productPictures,
        price,
        stock,
        color,
        rating,
        reviewsCount,
        discountPercentage,
        categories,
      ];
}
