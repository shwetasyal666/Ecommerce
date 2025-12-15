import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final List<String> images;
  final String categoryId;
  final String categoryName;
  final int stock;
  final double rating;
  final int reviewCount;
  final bool isFeatured;
  final DateTime createdAt;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    required this.images,
    required this.categoryId,
    required this.categoryName,
    required this.stock,
    required this.rating,
    required this.reviewCount,
    this.isFeatured = false,
    required this.createdAt,
  });

  bool get hasDiscount => discountPrice != null && discountPrice! < price;
  
  double get finalPrice => discountPrice ?? price;
  
  double get discountPercentage {
    if (!hasDiscount) return 0;
    return ((price - discountPrice!) / price * 100).roundToDouble();
  }
  
  bool get inStock => stock > 0;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        discountPrice,
        imageUrl,
        images,
        categoryId,
        categoryName,
        stock,
        rating,
        reviewCount,
        isFeatured,
        createdAt,
      ];
}