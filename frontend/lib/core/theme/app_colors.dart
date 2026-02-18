import 'package:flutter/material.dart';

class AppColors {
  // Primary - Medical Blue
  static const Color primary = Color(0xFF0D6EFD);
  static const Color primaryLight = Color(0xFF4D94FF);
  static const Color primaryDark = Color(0xFF0050C8);

  // Secondary - Warm Orange
  static const Color secondary = Color(0xFFFF6B35);
  static const Color secondaryLight = Color(0xFFFF9A6C);
  static const Color secondaryDark = Color(0xFFE05520);

  // Success / Health Green
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);

  // Warning
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  // Info Blue
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Error / Urgent Red
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);

  // Neutrals
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFF1F5F9);

  // Text
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0D6EFD), Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF9A6C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient healthGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
