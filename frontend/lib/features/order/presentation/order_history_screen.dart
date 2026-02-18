import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/order_provider.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.receipt_long_rounded,
                      size: 64,
                      color: AppColors.textHint.withValues(alpha: 0.3)),
                  const SizedBox(height: 12),
                  const Text('No orders yet',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Your order history will appear here',
                      style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return SlideUpFadeIn(
                delay: index * 80,
                child: AnimatedScaleButton(
                  onTap: () => context.push('/order/${order.id}'),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Order #${order.id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15)),
                            _StatusBadge(status: order.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (order.pharmacyName != null)
                          Row(
                            children: [
                              Icon(Icons.local_pharmacy_rounded,
                                  size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(order.pharmacyName!,
                                  style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13)),
                            ],
                          ),
                        const SizedBox(height: 6),
                        Text(
                            '${order.items.length} item${order.items.length != 1 ? 's' : ''} · ₹${order.totalAmount.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                        if (order.createdAt != null) ...[
                          const SizedBox(height: 4),
                          Text(order.createdAt!,
                              style: TextStyle(
                                  color: AppColors.textHint, fontSize: 12)),
                        ],
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
              const Text('Failed to load orders'),
              TextButton(
                  onPressed: () => ref.invalidate(ordersProvider),
                  child: const Text('Retry')),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status.toUpperCase()) {
      'PENDING' => AppColors.warning,
      'CONFIRMED' => AppColors.primary,
      'PREPARING' => AppColors.secondary,
      'OUT_FOR_DELIVERY' => AppColors.info,
      'DELIVERED' => AppColors.success,
      'CANCELLED' => AppColors.error,
      _ => AppColors.textSecondary,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status.replaceAll('_', ' '),
          style: TextStyle(
              color: color, fontWeight: FontWeight.w600, fontSize: 11)),
    );
  }
}
