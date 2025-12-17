import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double? discountPrice;

  @HiveField(5)
  final String imageUrl;

  @HiveField(6)
  final List<String> images;

  @HiveField(7)
  final String categoryId;

  @HiveField(8)
  final String categoryName;

  @HiveField(9)
  final int stock;

  @HiveField(10)
  final double rating;

  @HiveField(11)
  final int reviewCount;

  @HiveField(12)
  final bool isFeatured;

  @HiveField(13)
  final DateTime createdAt;

  const ProductModel({
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
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          discountPrice: discountPrice,
          imageUrl: imageUrl,
          images: images,
          categoryId: categoryId,
          categoryName: categoryName,
          stock: stock,
          rating: rating,
          reviewCount: reviewCount,
          isFeatured: isFeatured,
          createdAt: createdAt,
        );

  // From Firestore
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] as String,
      description: data['description'] as String,
      price: (data['price'] as num).toDouble(),
      discountPrice: data['discountPrice'] != null
          ? (data['discountPrice'] as num).toDouble()
          : null,
      imageUrl: data['imageUrl'] as String,
      images: List<String>.from(data['images'] as List? ?? []),
      categoryId: data['categoryId'] as String,
      categoryName: data['categoryName'] as String,
      stock: data['stock'] as int,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: data['reviewCount'] as int? ?? 0,
      isFeatured: data['isFeatured'] as bool? ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // To Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'discountPrice': discountPrice,
      'imageUrl': imageUrl,
      'images': images,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'isFeatured': isFeatured,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // From JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      discountPrice: json['discountPrice'] != null
          ? (json['discountPrice'] as num).toDouble()
          : null,
      imageUrl: json['imageUrl'] as String,
      images: List<String>.from(json['images'] as List),
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      stock: json['stock'] as int,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      isFeatured: json['isFeatured'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discountPrice': discountPrice,
      'imageUrl': imageUrl,
      'images': images,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'isFeatured': isFeatured,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}