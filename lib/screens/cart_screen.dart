import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';
import 'product_detail_screen.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const CartScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        // Consumer actively listens to the global CartProvider.
        // Any change (increment, decrement, deletion) will automatically natively rebuild this tree.
        child: Consumer<CartProvider>(
          builder: (context, cart, _) {
            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else if (onBack != null) {
                            onBack!();
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: AppColors.background,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Your Cart',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      if (cart.items.isNotEmpty)
                        TextButton.icon(
                          onPressed: () => cart.clearCart(),
                          icon: const Icon(
                            Icons.delete_outline,
                            size: 20,
                            color: AppColors.textSecondary,
                          ),
                          label: Text(
                            'Clear',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                    ],
                  ),
                ),

                // Cart Items List - Container
                Expanded(
                  child: Container(
                    color: AppColors.background,
                    child: cart.items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 64,
                                  color: AppColors.textSecondary.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Your cart is empty',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Add items to get started',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            // Cart Items List - ListView.separated
                            padding: const EdgeInsets.all(16),
                            itemCount: cart.items.length,
                            separatorBuilder: (_, _a) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = cart.items[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailScreen(
                                        productId: item.productId,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.04,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(
                                          0,
                                          2,
                                        ), // small shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      // Thumbnail
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl: item.image,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.contain,
                                          placeholder: (_, _a) => Container(
                                            width: 80,
                                            height: 80,
                                            color: AppColors.background,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // Details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '\$${item.price.toStringAsFixed(2)}',
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            // Quantity controls
                                            Row(
                                              children: [
                                                _QuantityButton(
                                                  icon: Icons.remove,
                                                  onTap: () =>
                                                      cart.decrementQuantity(
                                                        item.productId,
                                                      ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                      ),
                                                  child: Text(
                                                    '${item.quantity}',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.textPrimary,
                                                    ),
                                                  ),
                                                ),
                                                _QuantityButton(
                                                  icon: Icons.add,
                                                  onTap: () =>
                                                      cart.incrementQuantity(
                                                        item.productId,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),

                // Bottom checkout
                if (cart.items.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: const Border(
                        top: BorderSide(color: AppColors.border, width: 0.5),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              '\$${cart.total.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final messenger = ScaffoldMessenger.of(context);
                              messenger.hideCurrentSnackBar();
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Checkout coming soon!',
                                    style: GoogleFonts.inter(),
                                  ),
                                  backgroundColor: AppColors.primary,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.only(
                                    bottom: 80,
                                    left: 16,
                                    right: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.credit_card, size: 20),
                            label: const Text('Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
      ),
    );
  }
}
