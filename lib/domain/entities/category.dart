import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int productCount;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.productCount,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl, productCount];
}