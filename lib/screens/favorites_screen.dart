import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../providers/product_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavoritesProvider>();
    final productProvider = context.read<ProductProvider>();
    final favoriteProducts = productProvider.products
        .where((p) => favProvider.isFavorite(p.id))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.surface,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Favorites',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: favoriteProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          size: 64,
                          color: AppColors.textSecondary.withValues(alpha: 0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No favorites yet',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap the heart icon on products to save them here',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: favoriteProducts.length,
                    itemBuilder: (context, index) {
                      final product = favoriteProducts[index];
                      return ProductCard(product: product);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
