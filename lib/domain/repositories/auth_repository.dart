
import 'package:ecommerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithEmailAndPassword(
    String email,
    String password,
  );
  
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  );
  
  Future<Either<Failure, void>> signOut();
  
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);
  
  Future<Either<Failure, User?>> getCurrentUser();
  
  Stream<User?> get authStateChanges;
}