import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/pharmacy_provider.dart';

class PharmacyListScreen extends ConsumerWidget {
  const PharmacyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pharmaciesAsync = ref.watch(pharmacyListProvider(null));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Nearby Pharmacies'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: pharmaciesAsync.when(
        data: (pharmacies) {
          if (pharmacies.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.local_pharmacy_rounded,
                      size: 56,
                      color: AppColors.textHint.withValues(alpha: 0.3)),
                  const SizedBox(height: 12),
                  const Text('No pharmacies found',
                      style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pharmacies.length,
            itemBuilder: (context, index) {
              final p = pharmacies[index];
              return SlideUpFadeIn(
                delay: index * 80,
                child: AnimatedScaleButton(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                gradient: AppColors.healthGradient,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(Icons.local_pharmacy_rounded,
                                  color: Colors.white, size: 24),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(p.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16)),
                                      ),
                                      if (p.isVerified)
                                        Icon(Icons.verified_rounded,
                                            color: AppColors.primary, size: 16),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(p.address ?? '',
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            // Rating
                            Icon(Icons.star_rounded,
                                color: AppColors.warning, size: 16),
                            const SizedBox(width: 3),
                            Text('${p.rating ?? 0}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13)),
                            Text(' (${p.totalRatings ?? 0})',
                                style: TextStyle(
                                    color: AppColors.textHint, fontSize: 12)),
                            const SizedBox(width: 16),
                            // Hours
                            Icon(Icons.access_time_rounded,
                                color: AppColors.success, size: 14),
                            const SizedBox(width: 3),
                            Text(
                                p.is24Hours
                                    ? 'Open 24 Hours'
                                    : p.operatingHours ?? '',
                                style: TextStyle(
                                    color: AppColors.success,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.phone_outlined, size: 16),
                                label: const Text('Call'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  side: BorderSide(color: AppColors.border),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Order'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 8),
              const Text('Failed to load pharmacies'),
              TextButton(
                  onPressed: () => ref.invalidate(pharmacyListProvider(null)),
                  child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}
