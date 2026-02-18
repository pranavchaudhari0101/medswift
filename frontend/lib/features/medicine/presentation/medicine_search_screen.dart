import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/medicine_provider.dart';
import '../../../core/models/medicine_models.dart';

/// A debounced search query provider.
final _searchQueryProvider = StateProvider<String?>((ref) => null);

class MedicineSearchScreen extends ConsumerStatefulWidget {
  const MedicineSearchScreen({super.key});

  @override
  ConsumerState<MedicineSearchScreen> createState() =>
      _MedicineSearchScreenState();
}

class _MedicineSearchScreenState extends ConsumerState<MedicineSearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(_searchQueryProvider.notifier).state =
          value.isEmpty ? null : value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(_searchQueryProvider);
    final medicinesAsync = ref.watch(medicineSearchProvider(query));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Search Medicines'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            color: AppColors.surface,
            child: TextField(
              controller: _controller,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by name or composition...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _controller.clear();
                          ref.read(_searchQueryProvider.notifier).state = null;
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.border)),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          // Results
          Expanded(
            child: medicinesAsync.when(
              data: (medicines) {
                if (medicines.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 56,
                            color: AppColors.textHint.withValues(alpha: 0.3)),
                        const SizedBox(height: 12),
                        Text(
                            query != null
                                ? 'No medicines found for "$query"'
                                : 'Search for medicines',
                            style: TextStyle(
                                color: AppColors.textSecondary, fontSize: 15)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: medicines.length,
                  itemBuilder: (context, index) {
                    return SlideUpFadeIn(
                      delay: index * 60,
                      child: _MedicineCard(medicine: medicines[index]),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, color: AppColors.error, size: 40),
                    const SizedBox(height: 8),
                    const Text('Failed to load medicines'),
                    TextButton(
                        onPressed: () =>
                            ref.invalidate(medicineSearchProvider(query)),
                        child: const Text('Retry')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicineCard extends StatelessWidget {
  final Medicine medicine;
  const _MedicineCard({required this.medicine});

  @override
  Widget build(BuildContext context) {
    return AnimatedScaleButton(
      onTap: () => context.push('/medicine/${medicine.id}'),
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
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.medication_rounded,
                  color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(medicine.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(medicine.manufacturer ?? '',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13)),
                  if (medicine.requiresPrescription)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_user_rounded,
                              size: 10, color: AppColors.primary),
                          const SizedBox(width: 3),
                          Text('Rx Required',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (medicine.mrp != null)
              Text('₹${medicine.mrp!.toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
