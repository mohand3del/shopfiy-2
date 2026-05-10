class ProductModel {
  final String id;
  final String name;
  final String description;
  final String coverPictureUrl;
  final double price;
  final int stock;
  final int discountPercentage;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coverPictureUrl,
    required this.price,
    required this.stock,
    required this.discountPercentage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      coverPictureUrl: (json['coverPictureUrl'] ?? '').toString(),
      price: _toDouble(json['price']),
      stock: _toInt(json['stock']),
      discountPercentage: _toInt(json['discountPercentage']),
    );
  }

  static double _toDouble(dynamic v) {
    if (v is num) return v.toDouble();
    return double.tryParse(v?.toString() ?? '') ?? 0;
  }

  static int _toInt(dynamic v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }
}
