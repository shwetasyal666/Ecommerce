import 'package:ecommerce/features/authentication/data/datasources/local/hive_services.dart';
import 'package:ecommerce/features/authentication/domain/usecases/forget_password_usecase.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Auth imports
import 'features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'features/authentication/data/datasources/remote/firebase_auth_datasource.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/login_usecase.dart';
import 'features/authentication/domain/usecases/register_usecase.dart';
import 'features/authentication/domain/usecases/logout_usecase.dart';
import 'features/authentication/domain/usecases/get_current_user_usecase.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';

// Product imports
import 'features/product/data/datasources/local/product_local_datasource.dart';
import 'features/product/data/datasources/remote/product_remote_datasource.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecase/get_products_usecase.dart';
import 'features/product/domain/usecase/get_featured_products_usecase.dart';
import 'features/product/domain/usecase/get_product_detail_usecase.dart';
import 'features/product/domain/usecase/search_products_usecase.dart';
import 'features/product/domain/usecase/get_categories_usecase.dart';
import 'features/product/domain/usecase/get_products_by_category_usecase.dart';

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