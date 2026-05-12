import 'package:practical_cubit/core/cubit/async_state.dart';
import 'package:practical_cubit/features/products/domain/entities/product.dart';
import 'package:practical_cubit/features/products/presentation/cubits/products_cubit.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/common_widgets.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/product_shimmer.dart';
import 'package:practical_cubit/features/products/presentation/views/widgets/products/products_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsGridSection extends StatelessWidget {
  final Function(Product)? onProductTap;
  final bool showAllProducts;
  final int? maxProducts;

  const ProductsGridSection({
    super.key,
    this.onProductTap,
    this.showAllProducts = false,
    this.maxProducts,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, AsyncState<List<Product>>>(
      builder: (context, state) {
        return state.when(
          initial: () => const ProductsGridShimmer(),
          loading: () => const ProductsGridShimmer(),
          success: (List<Product> products) {
            if (products.isEmpty) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const EmptyState(
                    title: 'No Products Available',
                    subtitle: 'Check back later for new products',
                    icon: CupertinoIcons.cube_box,
                  ),
                ),
              );
            }

            final displayProducts = showAllProducts
                ? products
                : products.take(maxProducts ?? products.length).toList();

            return ProductsGrid(
              products: displayProducts,
              onProductTap: onProductTap,
            );
          },
          failure: (failure) => SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: EmptyState(
                title: 'Failed to Load Products',
                subtitle: failure.message,
                icon: CupertinoIcons.exclamationmark_triangle,
                actionText: 'Retry',
                onActionTap: () =>
                    context.read<ProductsCubit>().fetchAllProducts(),
              ),
            ),
          ),
        );
      },
    );
  }
}
