import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call(String categoryId) async {
    return await repository.getProductsByCategory(categoryId);
  }
}