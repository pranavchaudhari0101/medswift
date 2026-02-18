import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final profileAsync = ref.watch(userProfileProvider);

    final name = profileAsync.whenOrNull(data: (p) => p.name) ??
        authState.user?.name ??
        'User';
    final phone = profileAsync.whenOrNull(data: (p) => p.phone) ??
        authState.user?.phone ??
        '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar
            SlideUpFadeIn(
              delay: 0,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    Text(phone,
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            // Menu items
            _MenuItem(
                icon: Icons.person_outline,
                label: 'Edit Profile',
                onTap: () => context.push('/profile/edit'),
                delay: 100),
            _MenuItem(
                icon: Icons.location_on_outlined,
                label: 'Manage Addresses',
                onTap: () => context.push('/profile/addresses'),
                delay: 150),
            _MenuItem(
                icon: Icons.receipt_long_outlined,
                label: 'Order History',
                onTap: () => context.push('/orders'),
                delay: 200),
            _MenuItem(
                icon: Icons.description_outlined,
                label: 'My Prescriptions',
                onTap: () => context.push('/prescriptions'),
                delay: 250),
            _MenuItem(
                icon: Icons.help_outline_rounded,
                label: 'Help & Support',
                delay: 300),
            _MenuItem(
                icon: Icons.info_outline_rounded,
                label: 'About MedSwift',
                delay: 350),
            const SizedBox(height: 16),
            SlideUpFadeIn(
              delay: 400,
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ref.read(authProvider.notifier).logout();
                    context.go('/login');
                  },
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: const Text('Logout'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: BorderSide(
                        color: AppColors.error.withValues(alpha: 0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final int delay;

  const _MenuItem(
      {required this.icon, required this.label, this.onTap, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return SlideUpFadeIn(
      delay: delay,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: ListTile(
          leading: Icon(icon, color: AppColors.textSecondary, size: 22),
          title: Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          trailing:
              Icon(Icons.chevron_right_rounded, color: AppColors.textHint),
          onTap: onTap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }
}
