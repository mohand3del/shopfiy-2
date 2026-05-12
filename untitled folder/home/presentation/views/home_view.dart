import 'package:animate_do/animate_do.dart';
import 'package:e_commerce_app/core/di/service_locator.dart';
import 'package:e_commerce_app/core/helper/navigation_helper.dart';
import 'package:e_commerce_app/core/widgets/background_overlay.dart';
import 'package:e_commerce_app/core/widgets/blurred_backdrop.dart';
import 'package:e_commerce_app/features/auth/presentation/views/forgot_password/widgets/positioned_blur_images.dart'
    show PositionedBlurImages;
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/presentation/cubits/offers_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/cubits/products_cubit.dart';
import 'package:e_commerce_app/features/products/presentation/views/product_details_view.dart';
import 'package:e_commerce_app/features/products/presentation/views/products_view.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/products/featured_products_section.dart';
import 'package:e_commerce_app/features/products/presentation/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();

    void onProductTap(Product product) {
      NavigationHelper.pushWithFadeTransition(
        context,
        ProductDetailsView(productId: product.id),
      );
    }

    // View all tap handler
    void onViewAllTap() {
      NavigationHelper.pushWithCupertinoTransition(context, ProductsView());
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProductsCubit>()..fetchAllProducts(),
        ),
        BlocProvider(create: (context) => getIt<OffersCubit>()..fetchOffers()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F7),
        body: Stack(
          children: [
            const BackgroundOverlay(),
            FadeInDown(
              duration: const Duration(seconds: 2),
              child: const PositionedBlurImages(),
            ),
            FadeInUp(
              duration: const Duration(seconds: 2),
              delay: const Duration(milliseconds: 300),
              child: const BlurredBackdrop(),
            ),
            SafeArea(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: _buildHomeHeader(searchController)),
                  SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                  SliverToBoxAdapter(
                    child: OffersCarousel(
                      onOfferTap: (offer) {
                        debugPrint('Offer tapped: ${offer.name}');
                        // TODO: Navigate to offer details
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                  SliverToBoxAdapter(
                    child: FeaturedProductsSection(
                      onProductTap: onProductTap,
                      onViewAllTap: onViewAllTap,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeHeader(TextEditingController searchController) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Welcome Back',
            subtitle: 'Discover amazing deals',
            showNotification: true,
            showCart: true,
            onNotificationTap: () => debugPrint('Notifications tapped'),
            onCartTap: () => debugPrint('Cart tapped'),
          ),
          SizedBox(height: 20.h),
          SearchBarWidget(
            controller: searchController,
            hintText: 'Search for products...',
            onTap: () => debugPrint('Search tapped'),
          ),
        ],
      ),
    );
  }
}
