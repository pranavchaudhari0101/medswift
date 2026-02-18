import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';

class PrescriptionUploadScreen extends StatelessWidget {
  const PrescriptionUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Prescription')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideUpFadeIn(
              delay: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.15)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.info_outline_rounded,
                          color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Upload a valid prescription for medicines marked as Rx. Our pharmacist will verify it within minutes.',
                        style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SlideUpFadeIn(
              delay: 100,
              child: AnimatedScaleButton(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignInside),
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primary.withValues(alpha: 0.03),
                  ),
                  child: Column(
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.8, end: 1.0),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) =>
                            Transform.scale(scale: value, child: child),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.cloud_upload_rounded,
                              size: 40, color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Tap to upload prescription',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text('JPG, PNG, or PDF (max 10MB)',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textHint)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SlideUpFadeIn(
              delay: 200,
              child: Row(
                children: [
                  Expanded(
                      child: _buildUploadOption(
                          icon: Icons.camera_alt_rounded,
                          label: 'Camera',
                          color: AppColors.primary,
                          onTap: () {})),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildUploadOption(
                          icon: Icons.photo_library_rounded,
                          label: 'Gallery',
                          color: AppColors.success,
                          onTap: () {})),
                  const SizedBox(width: 12),
                  Expanded(
                      child: _buildUploadOption(
                          icon: Icons.picture_as_pdf_rounded,
                          label: 'PDF',
                          color: AppColors.error,
                          onTap: () {})),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SlideUpFadeIn(
              delay: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Prescription Guidelines',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  _buildGuideline(Icons.check_circle_outline,
                      'Ensure the prescription is clearly visible'),
                  _buildGuideline(Icons.check_circle_outline,
                      'Include doctor\'s name, date, and signature'),
                  _buildGuideline(Icons.check_circle_outline,
                      'Prescription must be less than 6 months old'),
                  _buildGuideline(Icons.check_circle_outline,
                      'All medicines should be listed clearly'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SlideUpFadeIn(
              delay: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Prescriptions',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  _buildPastPrescription('Dr. Sharma - General Checkup',
                      '15 Feb 2026', 'Verified'),
                  _buildPastPrescription(
                      'Dr. Patel - Diabetes Review', '02 Feb 2026', 'Verified'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadOption(
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onTap}) {
    return AnimatedScaleButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary)),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideline(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.success),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style:
                      TextStyle(fontSize: 14, color: AppColors.textSecondary))),
        ],
      ),
    );
  }

  Widget _buildPastPrescription(String title, String date, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.description_rounded,
                color: AppColors.success, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14)),
                Text(date,
                    style: TextStyle(fontSize: 12, color: AppColors.textHint)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(status,
                style: TextStyle(
                    color: AppColors.success,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
