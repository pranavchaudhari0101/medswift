import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/medicine_provider.dart';
import '../../../core/providers/cart_provider.dart';

class MedicineDetailScreen extends ConsumerWidget {
  final String medicineId;
  const MedicineDetailScreen({super.key, required this.medicineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = int.tryParse(medicineId) ?? 0;
    final medicineAsync = ref.watch(medicineDetailProvider(id));
    final pricesAsync = ref.watch(medicinePricesProvider(id));
    final alternativesAsync = ref.watch(medicineAlternativesProvider(id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Medicine Details'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: medicineAsync.when(
        data: (medicine) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SlideUpFadeIn(
                delay: 0,
                child: Row(
                  children: [
                    Hero(
                      tag: 'med-${medicine.id}',
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.medication_rounded,
                            color: Colors.white, size: 34),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(medicine.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                          Text(medicine.manufacturer ?? '',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14)),
                          if (medicine.requiresPrescription)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text('Rx Required',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600)),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Price + Add to Cart
              SlideUpFadeIn(
                delay: 100,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('₹${medicine.mrp?.toStringAsFixed(2) ?? 'N/A'}',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w800)),
                          const SizedBox(width: 8),
                          const Text('MRP',
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Show price comparison pharmacy prices for 'Add to Cart'
                      pricesAsync.when(
                        data: (prices) {
                          if (prices.isEmpty) {
                            return const Text('Not available at any pharmacy',
                                style:
                                    TextStyle(color: AppColors.textSecondary));
                          }
                          final best = prices.first;
                          return AnimatedScaleButton(
                            onTap: () {
                              ref.read(cartProvider.notifier).addItem(
                                    medicine,
                                    best.pharmacyId,
                                    best.pharmacyName,
                                    best.price,
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('${medicine.name} added to cart'),
                                  action: SnackBarAction(
                                      label: 'View Cart',
                                      onPressed: () => context.push('/cart')),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                    'Add to Cart — ₹${best.price.toStringAsFixed(2)} (${best.pharmacyName})',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                              ),
                            ),
                          );
                        },
                        loading: () => const SizedBox(
                            height: 48,
                            child: Center(child: CircularProgressIndicator())),
                        error: (_, __) => const Text('Could not load prices'),
                      ),
                    ],
                  ),
                ),
              ),
              // Description
              if (medicine.description != null) ...[
                const SizedBox(height: 20),
                SlideUpFadeIn(
                  delay: 200,
                  child: _Section(
                    title: 'Description',
                    child: Text(medicine.description!,
                        style: const TextStyle(fontSize: 14, height: 1.5)),
                  ),
                ),
              ],
              // Dosage
              if (medicine.dosage != null) ...[
                const SizedBox(height: 16),
                SlideUpFadeIn(
                  delay: 300,
                  child: _Section(
                    title: 'Dosage',
                    child: Row(
                      children: [
                        Icon(Icons.schedule_rounded,
                            color: AppColors.primary, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(medicine.dosage!,
                                style: const TextStyle(fontSize: 14))),
                      ],
                    ),
                  ),
                ),
              ],
              // Side Effects
              if (medicine.sideEffects != null) ...[
                const SizedBox(height: 16),
                SlideUpFadeIn(
                  delay: 400,
                  child: _Section(
                    title: 'Side Effects',
                    child: Text(medicine.sideEffects!,
                        style: const TextStyle(fontSize: 14, height: 1.5)),
                  ),
                ),
              ],
              // Price Comparison
              const SizedBox(height: 20),
              SlideUpFadeIn(
                delay: 500,
                child: const Text('Price Comparison',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 12),
              pricesAsync.when(
                data: (prices) => Column(
                  children: prices.map((p) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.local_pharmacy_rounded,
                              color: AppColors.success, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p.pharmacyName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                                Text(p.pharmacyAddress ?? '',
                                    style: TextStyle(
                                        color: AppColors.textHint,
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('₹${p.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15)),
                              Text(p.inStock ? 'In Stock' : 'Out of Stock',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: p.inStock
                                          ? AppColors.success
                                          : AppColors.error,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text('Could not load prices'),
              ),
              // Alternatives
              const SizedBox(height: 20),
              SlideUpFadeIn(
                delay: 600,
                child: const Text('Generic Alternatives',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 12),
              alternativesAsync.when(
                data: (alternatives) {
                  if (alternatives.isEmpty) {
                    return Text('No alternatives found',
                        style: TextStyle(color: AppColors.textSecondary));
                  }
                  return Column(
                    children: alternatives.map((alt) {
                      return AnimatedScaleButton(
                        onTap: () => context.push('/medicine/${alt.id}'),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.success.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.medication_rounded,
                                    color: AppColors.success, size: 18),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(alt.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13)),
                                    Text(alt.manufacturer ?? '',
                                        style: TextStyle(
                                            color: AppColors.textHint,
                                            fontSize: 11)),
                                  ],
                                ),
                              ),
                              Text('₹${alt.mrp?.toStringAsFixed(0) ?? '-'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text('Could not load alternatives'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 8),
              const Text('Failed to load medicine details'),
              TextButton(
                  onPressed: () => ref.invalidate(medicineDetailProvider(id)),
                  child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
