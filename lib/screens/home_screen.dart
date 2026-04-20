import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_theme.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();
      if (provider.products.isEmpty) {
        provider.fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          children: [
            // Top Section (White Background)
            Container(
              color: AppColors.surface,
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Added top padding to compensate for missing title spacing
                    const SizedBox(height: 16),

                    // Search bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/kora-logo.svg',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) =>
                                  setState(() => _searchQuery = value),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppColors.textPrimary,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search products...',
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 16, right: 8),
                                  child: Icon(
                                    Icons.search,
                                    size: 24,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 48,
                                  minHeight: 24,
                                ),
                                // isDense decoupled from global limits allows custom lower height padding
                                isDense: true,
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                                // Explicitly overriding enabledBorder prevents AppTheme from enforcing 16px radius
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1.5,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.background,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications_none,
                              size: 20,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Category chips
                    Consumer<ProductProvider>(
                      builder: (context, provider, _) {
                        return SizedBox(
                          height: 36,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: provider.categories.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final category = provider.categories[index];
                              final isSelected =
                                  provider.selectedCategory == category;
                              return GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  provider.setCategory(category);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.surface,
                                    borderRadius: BorderRadius.circular(24),
                                    border: isSelected
                                        ? null
                                        : Border.all(color: AppColors.border),
                                  ),
                                  child: Text(
                                    _formatCategory(category),
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Product grid
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (provider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.wifi_off,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            provider.error!,
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => provider.fetchProducts(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  final products = provider.searchProducts(_searchQuery);

                  if (products.isEmpty) {
                    return Center(
                      child: Text(
                        'No products found',
                        style: GoogleFonts.inter(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: products[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCategory(String category) {
    if (category == 'All') return 'All';
    return category
        .split(' ')
        .map((w) => w[0].toUpperCase() + w.substring(1))
        .join(' ');
  }
}
