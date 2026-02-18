import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SlideUpFadeIn(
              delay: 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, value, child) =>
                    Transform.scale(scale: value, child: child),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.local_pharmacy_rounded,
                      size: 48, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SlideUpFadeIn(
              delay: 100,
              child: Text('MedSwift',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.w800)),
            ),
            const SizedBox(height: 4),
            SlideUpFadeIn(
              delay: 150,
              child: Text('Version 1.0.0',
                  style: TextStyle(color: AppColors.textHint, fontSize: 14)),
            ),
            const SizedBox(height: 8),
            SlideUpFadeIn(
              delay: 200,
              child: Text('Your Trusted Prescription Delivery Partner',
                  style:
                      TextStyle(color: AppColors.textSecondary, fontSize: 15)),
            ),
            const SizedBox(height: 32),
            SlideUpFadeIn(
              delay: 250,
              child: _buildInfoCard(
                  Icons.speed_rounded,
                  'Fast Delivery',
                  'Get your medicines delivered within 60 minutes from nearby verified pharmacies.',
                  AppColors.primary),
            ),
            SlideUpFadeIn(
              delay: 320,
              child: _buildInfoCard(
                  Icons.compare_arrows_rounded,
                  'Price Comparison',
                  'Compare prices across multiple pharmacies and get the best deal every time.',
                  AppColors.success),
            ),
            SlideUpFadeIn(
              delay: 390,
              child: _buildInfoCard(
                  Icons.verified_user_rounded,
                  'Verified Pharmacies',
                  'All partner pharmacies are verified and licensed ensuring genuine medicines.',
                  AppColors.secondary),
            ),
            const SizedBox(height: 24),
            SlideUpFadeIn(
              delay: 460,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    Text('Made with ❤️ in India',
                        style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    Text('© 2026 MedSwift Technologies Pvt. Ltd.',
                        style:
                            TextStyle(color: AppColors.textHint, fontSize: 12)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text('Privacy Policy',
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 13))),
                        Text(' • ',
                            style: TextStyle(color: AppColors.textHint)),
                        TextButton(
                            onPressed: () {},
                            child: Text('Terms of Service',
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 13))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String desc, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(desc,
                      style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
