import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      _Notification(
          'Order Delivered',
          'Your order #1001 from Apollo Pharmacy has been delivered.',
          '2 min ago',
          Icons.check_circle_rounded,
          AppColors.success,
          false),
      _Notification(
          'Out for Delivery',
          'Ravi Kumar is on the way with your order #1002.',
          '15 min ago',
          Icons.local_shipping_rounded,
          AppColors.secondary,
          false),
      _Notification(
          'Prescription Verified',
          'Your prescription from Dr. Sharma has been verified.',
          '1 hr ago',
          Icons.verified_rounded,
          AppColors.primary,
          true),
      _Notification(
          'Medicine Reminder',
          'Time to take Metformin 500mg (after lunch).',
          '3 hrs ago',
          Icons.alarm_rounded,
          const Color(0xFFF59E0B),
          true),
      _Notification(
          'Price Drop Alert',
          'Vitamin D3 60K price dropped from ₹130 to ₹110!',
          'Yesterday',
          Icons.trending_down_rounded,
          AppColors.success,
          true),
      _Notification(
          'Order Confirmed',
          'Your order #1003 from MedPlus has been confirmed.',
          'Yesterday',
          Icons.receipt_long_rounded,
          AppColors.primary,
          true),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Mark all read',
                style: TextStyle(color: AppColors.primary, fontSize: 13)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final n = notifications[index];
          return SlideUpFadeIn(
            delay: index * 60,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color:
                    n.isRead ? null : AppColors.primary.withValues(alpha: 0.03),
                border: Border(
                    bottom: BorderSide(
                        color: AppColors.border.withValues(alpha: 0.5))),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: n.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(n.icon, color: n.color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(n.title,
                                  style: TextStyle(
                                      fontWeight: n.isRead
                                          ? FontWeight.w500
                                          : FontWeight.w700,
                                      fontSize: 14)),
                            ),
                            if (!n.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(n.body,
                            style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                                height: 1.4)),
                        const SizedBox(height: 4),
                        Text(n.time,
                            style: TextStyle(
                                color: AppColors.textHint, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Notification {
  final String title, body, time;
  final IconData icon;
  final Color color;
  final bool isRead;
  _Notification(
      this.title, this.body, this.time, this.icon, this.color, this.isRead);
}
