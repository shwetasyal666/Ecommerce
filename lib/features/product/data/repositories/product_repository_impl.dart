import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/exception.dart';
import 'package:ecommerce/core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local/product_local_datasource.dart';
import '../datasources/remote/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts({int limit = 20}) async {
    try {
      final products = await remoteDataSource.getProducts(limit: limit);
      await localDataSource.cacheProducts(products);
      return Right(products);
    } on ServerException catch (e) {
      // Try to get cached products
      try {
        final cachedProducts = await localDataSource.getCachedProducts();
        if (cachedProducts.isNotEmpty) {
          return Right(cachedProducts);
        }
      } catch (_) {}
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch products'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFeaturedProducts() async {
    try {
      final products = await remoteDataSource.getFeaturedProducts();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch featured products'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String categoryId,
  ) async {
    try {
      final products = await remoteDataSource.getProductsByCategory(categoryId);
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch products by category'));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String productId) async {
    try {
      final product = await remoteDataSource.getProductById(productId);
      return Right(product);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch product details'));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final products = await remoteDataSource.searchProducts(query);
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to search products'));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      await localDataSource.cacheCategories(categories);
      return Right(categories);
    } on ServerException catch (e) {
      // Try to get cached categories
      try {
        final cachedCategories = await localDataSource.getCachedCategories();
        if (cachedCategories.isNotEmpty) {
          return Right(cachedCategories);
        }
      } catch (_) {}
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('Failed to fetch categories'));
    }
  }
}