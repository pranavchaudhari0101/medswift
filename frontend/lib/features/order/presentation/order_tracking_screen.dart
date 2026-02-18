import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';

class OrderTrackingScreen extends StatelessWidget {
  final int orderId;
  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order #$orderId')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideUpFadeIn(
              delay: 0,
              child: _buildStatusCard(),
            ),
            const SizedBox(height: 24),
            SlideUpFadeIn(
              delay: 100,
              child: Text('Order Timeline',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 16),
            SlideUpFadeIn(
              delay: 150,
              child: _buildTimeline(),
            ),
            const SizedBox(height: 24),
            SlideUpFadeIn(
              delay: 250,
              child: Text('Delivery Partner',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 12),
            SlideUpFadeIn(
              delay: 300,
              child: _buildDeliveryPartner(),
            ),
            const SizedBox(height: 24),
            SlideUpFadeIn(
              delay: 400,
              child: Text('Order Summary',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 12),
            SlideUpFadeIn(
              delay: 450,
              child: _buildOrderSummary(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.9, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, value, child) =>
          Transform.scale(scale: value, child: child),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(children: [
          const Icon(Icons.local_shipping_rounded,
              size: 48, color: Colors.white),
          const SizedBox(height: 12),
          const Text('Out for Delivery',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Estimated: 2:30 PM',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8))),
        ]),
      ),
    );
  }

  Widget _buildTimeline() {
    final steps = [
      ['Order Placed', '12:45 PM', true],
      ['Prescription Verified', '12:50 PM', true],
      ['Confirmed', '12:52 PM', true],
      ['Out for Delivery', '1:45 PM', true],
      ['Delivered', '', false],
    ];
    return Column(
      children: steps.asMap().entries.map((e) {
        final i = e.key;
        final s = e.value;
        final done = s[2] as bool;
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (i * 120)),
          curve: Curves.easeOut,
          builder: (context, value, child) => Opacity(
            opacity: value,
            child: child,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: done ? AppColors.success : AppColors.border,
                    shape: BoxShape.circle,
                  ),
                  child: done
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                if (i < steps.length - 1)
                  Container(
                      width: 2,
                      height: 36,
                      color: done ? AppColors.success : AppColors.border),
              ]),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(s[0] as String,
                          style: TextStyle(
                              fontWeight:
                                  done ? FontWeight.w600 : FontWeight.w400,
                              color: done
                                  ? AppColors.textPrimary
                                  : AppColors.textHint)),
                      if ((s[1] as String).isNotEmpty)
                        Text(s[1] as String,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textHint)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDeliveryPartner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
          child: Icon(Icons.person_rounded, color: AppColors.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ravi Kumar',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              Row(children: [
                Icon(Icons.star_rounded,
                    size: 14, color: const Color(0xFFF59E0B)),
                const Text(' 4.8', style: TextStyle(fontSize: 13)),
                Text(' • 1200+ deliveries',
                    style: TextStyle(color: AppColors.textHint, fontSize: 13)),
              ]),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.phone_rounded, color: AppColors.success),
          ),
        ),
      ]),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(children: [
        _item('Dolo 650', '×2', '₹56.00'),
        const Divider(height: 20),
        _item('Cetirizine 10', '×1', '₹18.00'),
        const Divider(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Delivery', style: TextStyle(color: AppColors.textSecondary)),
          Text('FREE',
              style: TextStyle(
                  color: AppColors.success, fontWeight: FontWeight.w600)),
        ]),
        const Divider(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Text('Total',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          Text('₹74.00',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        ]),
      ]),
    );
  }

  Widget _item(String name, String qty, String price) {
    return Row(children: [
      Expanded(
          child:
              Text(name, style: const TextStyle(fontWeight: FontWeight.w600))),
      Text(qty, style: TextStyle(color: AppColors.textHint)),
      const SizedBox(width: 16),
      Text(price, style: const TextStyle(fontWeight: FontWeight.w600)),
    ]);
  }
}
