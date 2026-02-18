import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Clear Cart?'),
                    content:
                        const Text('All items will be removed from your cart.'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: () {
                            cartNotifier.clear();
                            Navigator.pop(ctx);
                          },
                          child: Text('Clear',
                              style: TextStyle(color: AppColors.error))),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? _EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return SlideUpFadeIn(
                        delay: index * 80,
                        child: Dismissible(
                          key: ValueKey(item.medicine.id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.delete_rounded,
                                color: Colors.white),
                          ),
                          onDismissed: (_) =>
                              cartNotifier.removeItem(item.medicine.id),
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
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(Icons.medication_rounded,
                                      color: AppColors.primary, size: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.medicine.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14)),
                                      const SizedBox(height: 2),
                                      Text(item.pharmacyName,
                                          style: TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 12)),
                                      const SizedBox(height: 4),
                                      Text('₹${item.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                // Quantity controls
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Row(
                                    children: [
                                      _QtyButton(
                                          icon: Icons.remove,
                                          onTap: () =>
                                              cartNotifier.updateQuantity(
                                                  item.medicine.id,
                                                  item.quantity - 1)),
                                      SizedBox(
                                        width: 32,
                                        child: Text('${item.quantity}',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14)),
                                      ),
                                      _QtyButton(
                                          icon: Icons.add,
                                          onTap: () =>
                                              cartNotifier.updateQuantity(
                                                  item.medicine.id,
                                                  item.quantity + 1)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bottom Summary
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _SummaryRow('Subtotal',
                          '₹${cartNotifier.subtotal.toStringAsFixed(2)}'),
                      const SizedBox(height: 6),
                      _SummaryRow('Delivery Fee',
                          '₹${cartNotifier.deliveryFee.toStringAsFixed(2)}'),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      _SummaryRow(
                          'Total', '₹${cartNotifier.total.toStringAsFixed(2)}',
                          bold: true),
                      const SizedBox(height: 16),
                      AnimatedScaleButton(
                        onTap: () => context.push('/checkout'),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                                'Proceed to Checkout (${cartNotifier.itemCount} items)',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 16),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _SummaryRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                color: bold ? null : AppColors.textSecondary,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
                fontSize: bold ? 16 : 14)),
        Text(value,
            style: TextStyle(
                fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                fontSize: bold ? 18 : 14)),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.5 + value * 0.5,
                  child: child,
                ),
              );
            },
            child: Icon(Icons.shopping_cart_outlined,
                size: 80, color: AppColors.textHint.withValues(alpha: 0.3)),
          ),
          const SizedBox(height: 16),
          const Text('Your cart is empty',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Add medicines to get started',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          AnimatedScaleButton(
            onTap: () => context.go('/search'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Browse Medicines',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
