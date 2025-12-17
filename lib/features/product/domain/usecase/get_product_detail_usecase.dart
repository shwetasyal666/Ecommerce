import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetailUseCase {
  final ProductRepository repository;

  GetProductDetailUseCase(this.repository);

  Future<Either<Failure, Product>> call(String productId) async {
    return await repository.getProductById(productId);
  }
}