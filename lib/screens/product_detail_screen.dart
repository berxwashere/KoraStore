import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../providers/product_provider.dart';
import '../providers/favorites_provider.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = context.read<ProductProvider>().getProductById(productId);
    if (product == null) {
      return const Scaffold(body: Center(child: Text('Product not found')));
    }

    final favProvider = context.watch<FavoritesProvider>();
    final cartProvider = context.read<CartProvider>();
    final isFav = favProvider.isFavorite(product.id);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image with back button and actions
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        color: AppColors.background,
                        child: SafeArea(
                          bottom: false,
                          child: CachedNetworkImage(
                            imageUrl: product.image,
                            height: 280,
                            fit: BoxFit.contain,
                            placeholder: (_, __) => const SizedBox(
                              height: 280,
                              child: Center(
                                child: CircularProgressIndicator(color: AppColors.primary),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _CircleButton(
                                icon: Icons.arrow_back,
                                onTap: () => Navigator.pop(context),
                              ),
                              Row(
                                children: [
                                  _CircleButton(
                                    icon: Icons.share_outlined,
                                    onTap: () {},
                                  ),
                                  const SizedBox(width: 8),
                                  _CircleButton(
                                    icon: isFav ? Icons.favorite : Icons.favorite_outline,
                                    iconColor: isFav ? AppColors.primary : null,
                                    onTap: () => favProvider.toggleFavorite(product.id),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Product info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Rating row
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < product.rating.round()
                                      ? Icons.star
                                      : Icons.star_outline,
                                  size: 16,
                                  color: AppColors.rating,
                                );
                              }),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${product.rating}',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '  (${product.ratingCount} reviews)',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Price
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Description
                        Text(
                          product.description,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Color options (decorative)
                        Text(
                          'Color',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _ColorDot(color: AppColors.textPrimary, isSelected: true),
                            const SizedBox(width: 12),
                            _ColorDot(color: AppColors.primary),
                            const SizedBox(width: 12),
                            _ColorDot(color: Colors.white),
                            const SizedBox(width: 12),
                            _ColorDot(color: const Color(0xFF00A699)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Add to Cart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.surface,
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    cartProvider.addToCart(product);
                    final messenger = ScaffoldMessenger.of(context);
                    messenger.hideCurrentSnackBar();
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Added to cart!', style: GoogleFonts.inter()),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                  label: const Text('Add to Cart'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, this.iconColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: iconColor ?? AppColors.textPrimary),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const _ColorDot({required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2.5 : 1,
        ),
      ),
    );
  }
}
