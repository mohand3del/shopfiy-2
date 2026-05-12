import 'package:e_commerce_app/core/cubit/async_state.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/presentation/cubits/products_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/common_widgets.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/featured_products_list.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/product_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturedProductsSection extends StatelessWidget {
  final Function(Product)? onProductTap;
  final VoidCallback? onViewAllTap;

  const FeaturedProductsSection({
    super.key,
    this.onProductTap,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, AsyncState<List<Product>>>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Featured Products',
              actionText: 'View All',
              onActionTap: onViewAllTap,
            ),
            Gap(16.h),
            state.when(
              initial: () => const FeaturedProductsListShimmer(),
              loading: () => const FeaturedProductsListShimmer(),
              success: (List<Product> products) {
                if (products.isEmpty) {
                  return SizedBox(
                    height: 280.h,
                    child: const EmptyState(
                      title: 'No Products Available',
                      subtitle: 'Check back later for new products',
                      icon: CupertinoIcons.cube_box,
                    ),
                  );
                }
                return FeaturedProductsList(
                  products: products.take(5).toList(),
                  onProductTap: onProductTap,
                );
              },
              failure: (failure) => SizedBox(
                height: 280.h,
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
          ],
        );
      },
    );
  }
}
