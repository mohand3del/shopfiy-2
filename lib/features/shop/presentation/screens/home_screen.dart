import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practical_cubit/core/presentation/app_snackbar.dart';
import 'package:practical_cubit/features/shop/domain/entities/product_entity.dart';
import 'package:practical_cubit/features/shop/presentation/cubit/home_cubit.dart';
import 'package:practical_cubit/features/shop/presentation/cubit/home_state.dart';

/// Lists products from GET `/api/products` (same contract as Scalar/OpenAPI).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeFailure) {
          AppSnackBar.error(context, state.message);
        }
      },
      builder: (context, state) {
        Widget body;
        if (state is HomeInitial || state is HomeLoading) {
          body = const Center(
            child: CircularProgressIndicator(
              color: Color(0xff004CFF),
            ),
          );
        } else if (state is HomeFailure) {
          body = Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xff202020)),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.read<HomeCubit>().loadProducts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else if (state is HomeLoaded) {
          final products = state.products;
          body = products.isEmpty
              ? const Center(child: Text('No products yet.'))
              : RefreshIndicator(
                  color: const Color(0xff004CFF),
                  onRefresh: () => context.read<HomeCubit>().refresh(),
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.56,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _ProductTile(product: products[index]);
                    },
                  ),
                );
        } else {
          body = const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Shop'),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xff202020),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          body: body,
        );
      },
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final priceLabel =
        '\$${product.price.toStringAsFixed(2)}';

    return Material(
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(9),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
              child: product.coverPictureUrl.isEmpty
                  ? Container(
                      color: const Color(0xFFF7F8F9),
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported_outlined),
                    )
                  : Image.network(
                      product.coverPictureUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFF7F8F9),
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image_outlined),
                      ),
                    ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.25,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          priceLabel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff202020),
                          ),
                        ),
                      ),
                      if (product.discountPercentage > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '-${product.discountPercentage}%',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
