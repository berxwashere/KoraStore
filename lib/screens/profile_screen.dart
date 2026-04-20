import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

import '../services/local_storage_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, size: 40, color: AppColors.primary),
              ),
              const SizedBox(height: 12),

              FutureBuilder<Map<String, String?>>(
                future: LocalStorageService().getCredentials(),
                builder: (context, snapshot) {
                  final email = snapshot.data?['email'] ?? 'guest@korastore.com';
                  final name = email.split('@').first.toUpperCase();
                  
                  return Column(
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 32),

              // Menu items
              _ProfileMenuItem(icon: Icons.shopping_bag_outlined, label: 'My Orders'),
              _ProfileMenuItem(icon: Icons.location_on_outlined, label: 'Shipping Addresses'),
              _ProfileMenuItem(icon: Icons.credit_card_outlined, label: 'Payment Methods'),
              _ProfileMenuItem(icon: Icons.notifications_outlined, label: 'Notifications'),
              _ProfileMenuItem(icon: Icons.settings_outlined, label: 'Settings'),
              _ProfileMenuItem(icon: Icons.help_outline, label: 'Help Center'),
              const SizedBox(height: 16),
              _ProfileMenuItem(
                icon: Icons.logout,
                label: 'Log Out',
                isDestructive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.primary : AppColors.textPrimary;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, size: 20, color: color),
        title: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 20,
          color: AppColors.textSecondary,
        ),
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
