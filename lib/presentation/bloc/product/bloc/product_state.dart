import 'package:ecommerce/domain/entities/category.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

enum ProductStatus {
  initial,
  loading,
  loaded,
  error,
  searching,
  searchSuccess,
  searchError,
}

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> products;
  final List<Product> featuredProducts;
  final List<Category> categories;
  final List<Product> searchResults;
  final Product? selectedProduct;
  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.featuredProducts = const [],
    this.categories = const [],
    this.searchResults = const [],
    this.selectedProduct,
    this.errorMessage,
  });

  bool get isLoading => status == ProductStatus.loading;
  bool get isSearching => status == ProductStatus.searching;
  bool get hasProducts => products.isNotEmpty;
  bool get hasCategories => categories.isNotEmpty;

  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    List<Product>? featuredProducts,
    List<Category>? categories,
    List<Product>? searchResults,
    Product? selectedProduct,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      categories: categories ?? this.categories,
      searchResults: searchResults ?? this.searchResults,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        featuredProducts,
        categories,
        searchResults,
        selectedProduct,
        errorMessage,
      ];
}