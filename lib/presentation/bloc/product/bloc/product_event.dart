
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {
  final int limit;

  const LoadProductsEvent({this.limit = 20});

  @override
  List<Object?> get props => [limit];
}

class LoadFeaturedProductsEvent extends ProductEvent {
  const LoadFeaturedProductsEvent();
}

class LoadProductDetailEvent extends ProductEvent {
  final String productId;

  const LoadProductDetailEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadCategoriesEvent extends ProductEvent {
  const LoadCategoriesEvent();
}

class LoadProductsByCategoryEvent extends ProductEvent {
  final String categoryId;

  const LoadProductsByCategoryEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class RefreshProductsEvent extends ProductEvent {
  const RefreshProductsEvent();
}