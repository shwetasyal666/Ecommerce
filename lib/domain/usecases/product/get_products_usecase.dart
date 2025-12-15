import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import '../../entities/product.dart';
import '../../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call({int limit = 20}) async {
    return await repository.getProducts(limit: limit);
  }
}