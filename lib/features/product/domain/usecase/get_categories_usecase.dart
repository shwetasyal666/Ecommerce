import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/failure.dart';
import '../entities/category.dart';
import '../repositories/product_repository.dart';

class GetCategoriesUseCase {
  final ProductRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}