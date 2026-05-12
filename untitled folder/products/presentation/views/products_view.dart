import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/widgets/background_overlay.dart';
import 'package:e_commerce_app/core/widgets/blur_images_overlay.dart';
import 'package:e_commerce_app/core/widgets/blurred_backdrop.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/presentation/cubits/products_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/views/product_details_view.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/products_grid_section.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/helper/navigation_helper.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onProductTap(Product product) {
    NavigationHelper.pushWithFadeTransition(
      context,
      ProductDetailsView(productId: product.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductsCubit>()..fetchAllProducts(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        body: Stack(
          children: [
            const BackgroundOverlay(),
            const BlurImagesOverlay(),
            const BlurredBackdrop(),
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildProductsHeader()),
                  SliverToBoxAdapter(child: Gap(32.h)),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    sliver: ProductsGridSection(
                      onProductTap: _onProductTap,
                      showAllProducts: true,
                    ),
                  ),

                  SliverToBoxAdapter(child: Gap(40.h)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButtonBlur(
                icon: Icons.arrow_back_ios,
                onTap: () => Navigator.of(context).pop(),
              ),
              Gap(16.w),
              Expanded(
                child: PageHeader(
                  title: 'Products',
                  subtitle: 'Discover our collection',
                  showCart: true,
                  onCartTap: () => debugPrint('Cart tapped'),
                ),
              ),
            ],
          ),
          Gap(20.h),
          SearchBarWidget(
            controller: searchController,
            hintText: 'Search products',
            onChanged: (value) {
              debugPrint('Search query: $value');
            },
          ),
        ],
      ),
    );
  }
}
