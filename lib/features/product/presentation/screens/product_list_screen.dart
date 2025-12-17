import 'package:ecommerce/core/common/error_widget.dart';
import 'package:ecommerce/core/common/loading_indecator.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce/features/product/presentation/screens/product_detail_screen.dart';
import 'package:ecommerce/features/product/presentation/widgets/product_card.dart';
import 'package:ecommerce/injectioncontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;

  const ProductListScreen({
    super.key,
    this.categoryId,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>()
        ..add(
          categoryId != null
              ? LoadProductsByCategoryEvent(categoryId!)
              : const LoadProductsEvent(),
        ),
      child: ProductListView(
        categoryName: categoryName,
      ),
    );
  }
}

class ProductListView extends StatelessWidget {
  final String? categoryName;

  const ProductListView({
    super.key,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName ?? 'All Products'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return const LoadingIndicator(message: 'Loading products...');
          }

          if (state.status == ProductStatus.error) {
            return CustomErrorWidget(
              message: state.errorMessage ?? 'Failed to load products',
              onRetry: () {
                context.read<ProductBloc>().add(const LoadProductsEvent());
              },
            );
          }

          if (state.products.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProductBloc>().add(const LoadProductsEvent());
              await Future.delayed(const Duration(seconds: 1));
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productId: product.id,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}