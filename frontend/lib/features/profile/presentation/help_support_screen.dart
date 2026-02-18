import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideUpFadeIn(
              delay: 0,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('How can we help?',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text('We\'re always here to assist you.',
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                    Icon(Icons.headset_mic_rounded,
                        size: 48, color: Colors.white.withValues(alpha: 0.3)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SlideUpFadeIn(
              delay: 100,
              child: Text('Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 12),
            SlideUpFadeIn(
              delay: 150,
              child: Row(
                children: [
                  Expanded(
                      child: _buildQuickAction(
                          Icons.chat_rounded, 'Live Chat', AppColors.primary)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildQuickAction(
                          Icons.email_rounded, 'Email Us', AppColors.success)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildQuickAction(
                          Icons.phone_rounded, 'Call Us', AppColors.secondary)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SlideUpFadeIn(
              delay: 200,
              child: Text('Frequently Asked Questions',
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 12),
            ..._buildFAQs(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color) {
    return AnimatedScaleButton(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFAQs(BuildContext context) {
    final faqs = [
      [
        'How do I upload a prescription?',
        'Tap the scan button on the home screen or go to Profile > My Prescriptions. You can upload images or PDFs of your prescription.'
      ],
      [
        'What is the delivery time?',
        'We deliver within 60 minutes from nearby pharmacies. Delivery times may vary based on your location and pharmacy availability.'
      ],
      [
        'How can I track my order?',
        'Go to My Orders and tap on any active order to see real-time tracking information.'
      ],
      [
        'Is my payment secure?',
        'Yes! We use industry-standard encryption and partner with trusted payment gateways to ensure your transactions are safe.'
      ],
      [
        'How do medicine reminders work?',
        'You can set daily reminders for your medicines with custom times and instructions. We\'ll send you notifications when it\'s time.'
      ],
      [
        'Can I return medicines?',
        'Due to safety regulations, medicines cannot be returned once delivered. Please verify your order before confirmation.'
      ],
    ];

    return faqs.asMap().entries.map((e) {
      return SlideUpFadeIn(
        delay: 250 + (e.key * 60),
        child: Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              title: Text(e.value[0],
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              children: [
                Text(e.value[1],
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.5)),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
