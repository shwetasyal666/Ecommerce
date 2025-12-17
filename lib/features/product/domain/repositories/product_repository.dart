import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import '../entities/product.dart';
import '../entities/category.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts({int limit = 20});
  Future<Either<Failure, List<Product>>> getFeaturedProducts();
  Future<Either<Failure, List<Product>>> getProductsByCategory(String categoryId);
  Future<Either<Failure, Product>> getProductById(String productId);
  Future<Either<Failure, List<Product>>> searchProducts(String query);
  Future<Either<Failure, List<Category>>> getCategories();
}