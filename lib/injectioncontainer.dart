import 'package:ecommerce/data/datasources/local/hive_services.dart';
import 'package:ecommerce/domain/usecases/auth/forget_password_usecase.dart';
import 'package:ecommerce/presentation/bloc/product/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Auth imports
import 'data/datasources/local/auth_local_datasource.dart';
import 'data/datasources/remote/firebase_auth_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/register_usecase.dart';
import 'domain/usecases/auth/logout_usecase.dart';
import 'domain/usecases/auth/get_current_user_usecase.dart';
import 'presentation/bloc/auth/auth_bloc.dart';

// Product imports
import 'data/datasources/local/product_local_datasource.dart';
import 'data/datasources/remote/product_remote_datasource.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/product/get_products_usecase.dart';
import 'domain/usecases/product/get_featured_products_usecase.dart';
import 'domain/usecases/product/get_product_detail_usecase.dart';
import 'domain/usecases/product/search_products_usecase.dart';
import 'domain/usecases/product/get_categories_usecase.dart';
import 'domain/usecases/product/get_products_by_category_usecase.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  try {
    // ============ External ============
    sl.registerLazySingleton(() => FirebaseAuth.instance);
    sl.registerLazySingleton(() => FirebaseFirestore.instance);
    print('✅ External dependencies registered');

    // ============ Core ============
    sl.registerLazySingleton(() => HiveService());
    print('✅ Core services registered');

    // ============ Auth Module ============
    // Data sources
    sl.registerLazySingleton<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSourceImpl(
        firebaseAuth: sl(),
        firestore: sl(),
      ),
    );

    sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()),
    );

    // Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    );

    // Use cases
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => RegisterUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
    sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));

    // BLoC
    sl.registerFactory(
      () => AuthBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
        logoutUseCase: sl(),
        forgotPasswordUseCase: sl(),
        getCurrentUserUseCase: sl(),
        authRepository: sl(),
      ),
    );
    print('✅ Auth module registered');

    // ============ Product Module ============
    // Data sources
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(firestore: sl()),
    );

    sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sl()),
    );

    // Repository
    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ),
    );

    // Use cases
    sl.registerLazySingleton(() => GetProductsUseCase(sl()));
    sl.registerLazySingleton(() => GetFeaturedProductsUseCase(sl()));
    sl.registerLazySingleton(() => GetProductDetailUseCase(sl()));
    sl.registerLazySingleton(() => SearchProductsUseCase(sl()));
    sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
    sl.registerLazySingleton(() => GetProductsByCategoryUseCase(sl()));

    // BLoC
    sl.registerFactory(
      () => ProductBloc(
        getProductsUseCase: sl(),
        getFeaturedProductsUseCase: sl(),
        getProductDetailUseCase: sl(),
        searchProductsUseCase: sl(),
        getCategoriesUseCase: sl(),
        getProductsByCategoryUseCase: sl(),
      ),
    );
    print('✅ Product module registered');

    print('✅ All dependencies initialized successfully');
  } catch (e, stackTrace) {
    print('❌ Dependency injection error: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}