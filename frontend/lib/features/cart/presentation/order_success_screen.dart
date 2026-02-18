import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/animated_scale_button.dart';

class OrderSuccessScreen extends StatefulWidget {
  final String orderId;
  const OrderSuccessScreen({super.key, required this.orderId});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated checkmark
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.healthGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.success.withValues(alpha: 0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 50),
                  ),
                ),
                const SizedBox(height: 28),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      const Text('Order Placed!',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Text('Your order #${widget.orderId} is being processed.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                              height: 1.5)),
                      const SizedBox(height: 6),
                      Text('Estimated delivery: 30-45 minutes',
                          style: TextStyle(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 40),
                      AnimatedScaleButton(
                        onTap: () => context.go('/order/${widget.orderId}'),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: Text('Track Order',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedScaleButton(
                        onTap: () => context.go('/home'),
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Center(
                            child: Text('Continue Shopping',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
