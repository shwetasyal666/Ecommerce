import 'package:ecommerce/domain/usecases/product/get_categories_usecase.dart';
import 'package:ecommerce/domain/usecases/product/get_featured_products_usecase.dart';
import 'package:ecommerce/domain/usecases/product/get_product_detail_usecase.dart';
import 'package:ecommerce/domain/usecases/product/get_products_by_category_usecase.dart';
import 'package:ecommerce/domain/usecases/product/get_products_usecase.dart';
import 'package:ecommerce/domain/usecases/product/search_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetFeaturedProductsUseCase getFeaturedProductsUseCase;
  final GetProductDetailUseCase getProductDetailUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.getFeaturedProductsUseCase,
    required this.getProductDetailUseCase,
    required this.searchProductsUseCase,
    required this.getCategoriesUseCase,
    required this.getProductsByCategoryUseCase,
  }) : super(const ProductState()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<LoadFeaturedProductsEvent>(_onLoadFeaturedProducts);
    on<LoadProductDetailEvent>(_onLoadProductDetail);
    on<SearchProductsEvent>(_onSearchProducts);
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<LoadProductsByCategoryEvent>(_onLoadProductsByCategory);
    on<RefreshProductsEvent>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));

    final result = await getProductsUseCase(limit: event.limit);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          status: ProductStatus.loaded,
          products: products,
        ),
      ),
    );
  }

  Future<void> _onLoadFeaturedProducts(
    LoadFeaturedProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await getFeaturedProductsUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          featuredProducts: products,
        ),
      ),
    );
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetailEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));

    final result = await getProductDetailUseCase(event.productId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (product) => emit(
        state.copyWith(
          status: ProductStatus.loaded,
          selectedProduct: product,
        ),
      ),
    );
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(state.copyWith(
        status: ProductStatus.loaded,
        searchResults: [],
      ));
      return;
    }

    emit(state.copyWith(status: ProductStatus.searching));

    final result = await searchProductsUseCase(event.query);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductStatus.searchError,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          status: ProductStatus.searchSuccess,
          searchResults: products,
        ),
      ),
    );
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<ProductState> emit,
  ) async {
    final result = await getCategoriesUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          categories: categories,
        ),
      ),
    );
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading));

    final result = await getProductsByCategoryUseCase(event.categoryId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ProductStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          status: ProductStatus.loaded,
          products: products,
        ),
      ),
    );
  }

  Future<void> _onRefreshProducts(
    RefreshProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Load both products and categories
    add(const LoadProductsEvent());
    add(const LoadFeaturedProductsEvent());
    add(const LoadCategoriesEvent());
  }
}