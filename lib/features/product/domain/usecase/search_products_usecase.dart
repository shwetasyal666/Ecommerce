import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(String query) async {
    if (query.isEmpty) {
      return const Right([]);
    }
    return await repository.searchProducts(query);
  }
}