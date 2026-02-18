import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/medicine_provider.dart';
import '../../../core/providers/pharmacy_provider.dart';
import '../../../core/providers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userName = authState.user?.name ?? 'there';
    final medicinesAsync = ref.watch(medicineSearchProvider(null));
    final pharmaciesAsync = ref.watch(pharmacyListProvider(null));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Header
              SlideUpFadeIn(
                delay: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Good Morning 👋',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14)),
                          Text(userName,
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    AnimatedScaleButton(
                      onTap: () => context.push('/notifications'),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child:
                            const Icon(Icons.notifications_outlined, size: 22),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Search bar
              SlideUpFadeIn(
                delay: 100,
                child: AnimatedScaleButton(
                  onTap: () => context.go('/search'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search_rounded,
                            color: AppColors.textHint, size: 20),
                        const SizedBox(width: 12),
                        Text('Search medicines, health products...',
                            style: TextStyle(
                                color: AppColors.textHint, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Quick Actions
              SlideUpFadeIn(
                delay: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _QuickAction(
                        icon: Icons.medication_rounded,
                        label: 'Order\nMedicine',
                        color: AppColors.primary,
                        onTap: () => context.go('/search')),
                    _QuickAction(
                        icon: Icons.document_scanner_rounded,
                        label: 'Upload\nRx',
                        color: AppColors.success,
                        onTap: () => context.push('/prescription/upload')),
                    _QuickAction(
                        icon: Icons.local_pharmacy_rounded,
                        label: 'Find\nPharmacy',
                        color: AppColors.secondary,
                        onTap: () => context.push('/pharmacies')),
                    _QuickAction(
                        icon: Icons.folder_shared_rounded,
                        label: 'Health\nRecords',
                        color: AppColors.warning,
                        onTap: () {}),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Popular Medicines
              SlideUpFadeIn(
                delay: 300,
                child: Text('Popular Medicines',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 12),
              medicinesAsync.when(
                data: (medicines) => SizedBox(
                  height: 140,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: medicines.length > 6 ? 6 : medicines.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final m = medicines[index];
                      return SlideUpFadeIn(
                        delay: 350 + index * 60,
                        child: AnimatedScaleButton(
                          onTap: () => context.push('/medicine/${m.id}'),
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.medication_rounded,
                                      color: AppColors.primary, size: 22),
                                ),
                                const SizedBox(height: 8),
                                Text(m.name,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                if (m.mrp != null)
                                  Text('₹${m.mrp!.toStringAsFixed(0)}',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary)),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                loading: () => const SizedBox(
                    height: 140,
                    child: Center(child: CircularProgressIndicator())),
                error: (e, _) => _ErrorBanner(
                    message: 'Could not load medicines',
                    onRetry: () =>
                        ref.invalidate(medicineSearchProvider(null))),
              ),
              const SizedBox(height: 28),
              // Nearby Pharmacies
              SlideUpFadeIn(
                delay: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Nearby Pharmacies',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    TextButton(
                        onPressed: () => context.push('/pharmacies'),
                        child: const Text('View All')),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              pharmaciesAsync.when(
                data: (pharmacies) => Column(
                  children:
                      pharmacies.take(3).toList().asMap().entries.map((e) {
                    final p = e.value;
                    return SlideUpFadeIn(
                      delay: 450 + e.key * 80,
                      child: AnimatedScaleButton(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: AppColors.healthGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.local_pharmacy_rounded,
                                    color: Colors.white, size: 22),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(p.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14)),
                                        if (p.isVerified) ...[
                                          const SizedBox(width: 4),
                                          Icon(Icons.verified_rounded,
                                              color: AppColors.primary,
                                              size: 14),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    Text(p.address ?? '',
                                        style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star_rounded,
                                      color: AppColors.warning, size: 16),
                                  const SizedBox(width: 2),
                                  Text('${p.rating ?? 0}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => _ErrorBanner(
                    message: 'Could not load pharmacies',
                    onRetry: () => ref.invalidate(pharmacyListProvider(null))),
              ),
              const SizedBox(height: 24),
              // Health tip
              SlideUpFadeIn(
                delay: 500,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.healthGradient,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Stay Healthy!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(
                                'Regular health checkups can help catch issues early.',
                                style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                      Icon(Icons.health_and_safety_rounded,
                          color: Colors.white.withValues(alpha: 0.3), size: 48),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickAction(
      {required this.icon,
      required this.label,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleButton(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorBanner({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.errorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, color: AppColors.error, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message,
                style: TextStyle(color: AppColors.error, fontSize: 13)),
          ),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
