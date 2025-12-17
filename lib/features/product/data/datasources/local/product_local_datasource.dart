
import 'package:ecommerce/core/constant/hive_constant.dart';
import 'package:ecommerce/core/error/exception.dart';
import 'package:ecommerce/features/authentication/data/datasources/local/hive_services.dart';

import '../../models/product_model.dart';
import '../../models/category_model.dart';

abstract class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<List<CategoryModel>> getCachedCategories();
  Future<void> clearCache();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final HiveService hiveService;

  ProductLocalDataSourceImpl(this.hiveService);

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      await hiveService.put(
        HiveConstants.productsBox,
        HiveConstants.cachedProductsKey,
        products,
      );
    } catch (e) {
      throw CacheException('Failed to cache products');
    }
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    try {
      final products = await hiveService.get<List>(
        HiveConstants.productsBox,
        HiveConstants.cachedProductsKey,
      );
      
      if (products == null) return [];
      
      return products.cast<ProductModel>();
    } catch (e) {
      throw CacheException('Failed to get cached products');
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    try {
      await hiveService.put(
        HiveConstants.productsBox,
        'cached_categories',
        categories,
      );
    } catch (e) {
      throw CacheException('Failed to cache categories');
    }
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    try {
      final categories = await hiveService.get<List>(
        HiveConstants.productsBox,
        'cached_categories',
      );
      
      if (categories == null) return [];
      
      return categories.cast<CategoryModel>();
    } catch (e) {
      throw CacheException('Failed to get cached categories');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await hiveService.clear(HiveConstants.productsBox);
    } catch (e) {
      throw CacheException('Failed to clear cache');
    }
  }
}