import 'package:e_commerce_app/core/cubit/async_state.dart';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/widgets/custom_shimmer.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/presentation/cubits/product_details_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/product_details/add_to_cart_button.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/product_details/product_header.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/product_details/reviews_section.dart';
import 'package:e_commerce_app/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductDetailsView extends StatelessWidget {
  final String? productId;

  const ProductDetailsView({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    // Otherwise, fetch the product by ID
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ProductDetailsCubit>()..fetchProductById(productId!),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ReviewsCubit>()..fetchProductReviews(productId!),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        appBar: _buildAppBar(context),
        body: BlocBuilder<ProductDetailsCubit, AsyncState<Product>>(
          builder: (context, state) {
            return state.when(
              initial: () => _buildLoadingState(),
              loading: () => _buildLoadingState(),
              success: (product) => _buildProductDetailsBody(context, product),
              failure: (failure) => _buildErrorState(context, failure.message),
            );
          },
        ),
      ),
    );
  }



  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.lightSecondary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Product Details',
        style: AppStyles.bold18(color: AppColors.lightSecondary),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProductDetailsBody(BuildContext context, Product product) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Product Header Section
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ProductHeader(product: product),
          ),
        ),

        // Add to Cart Button Section
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: AddToCartButton(product: product),
          ),
        ),

        // Spacing
        SliverToBoxAdapter(child: Gap(20.h)),

        // Reviews Section
        SliverToBoxAdapter(child: ReviewsSection(productId: product.id)),

        // Bottom padding
        SliverToBoxAdapter(child: Gap(40.h)),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomShimmer(height: 300.h, width: double.infinity),
          Gap(20.h),
          CustomShimmer(height: 20.h, width: 200.w),
          Gap(10.h),
          CustomShimmer(height: 16.h, width: 150.w),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.exclamationmark_triangle,
            size: 64.sp,
            color: AppColors.error,
          ),
          Gap(16.h),
          Text(
            'Failed to Load Product',
            style: AppStyles.bold18(color: AppColors.lightSecondary),
          ),
          Gap(8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppStyles.regular14(color: AppColors.grey600),
          ),
          Gap(20.h),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
