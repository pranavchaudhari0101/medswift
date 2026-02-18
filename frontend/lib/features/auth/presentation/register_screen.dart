import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int get _passwordStrength {
    final p = _passwordController.text;
    if (p.length >= 8) return 3;
    if (p.length >= 6) return 2;
    if (p.isNotEmpty) return 1;
    return 0;
  }

  void _handleRegister() {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (name.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in required fields')),
      );
      return;
    }
    ref
        .read(authProvider.notifier)
        .register(name, phone, email.isEmpty ? null : email, password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (prev, next) {
      if (next.status == AuthStatus.authenticated) {
        context.go('/home');
      }
      if (next.status == AuthStatus.error && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    final strength = _passwordStrength;
    final strengthColors = [
      Colors.transparent,
      AppColors.error,
      AppColors.warning,
      AppColors.success,
    ];
    final strengthLabels = ['', 'Weak', 'Medium', 'Strong'];
    final strengthWidths = [0.0, 0.33, 0.66, 1.0];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideUpFadeIn(
                delay: 0,
                child: Text('Create Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
              ),
              const SizedBox(height: 4),
              SlideUpFadeIn(
                delay: 0,
                child: Text('Join MedSwift for fast medicine delivery',
                    style: TextStyle(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: 32),
              // Name
              SlideUpFadeIn(
                delay: 100,
                child: TextField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Full Name *',
                    prefixIcon:
                        const Icon(Icons.person_outline_rounded, size: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Phone
              SlideUpFadeIn(
                delay: 200,
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number *',
                    prefixIcon:
                        const Icon(Icons.phone_android_rounded, size: 20),
                    prefixText: '+91 ',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Email
              SlideUpFadeIn(
                delay: 300,
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email (optional)',
                    prefixIcon: const Icon(Icons.email_outlined, size: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password
              SlideUpFadeIn(
                delay: 400,
                child: Column(
                  children: [
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        labelText: 'Password *',
                        prefixIcon:
                            const Icon(Icons.lock_outline_rounded, size: 20),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                          ),
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    if (strength > 0) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: AppColors.border,
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: strengthWidths[strength],
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: strengthColors[strength],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(strengthLabels[strength],
                              style: TextStyle(
                                  fontSize: 12,
                                  color: strengthColors[strength],
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 28),
              // Register button
              SlideUpFadeIn(
                delay: 500,
                child: AnimatedScaleButton(
                  onTap: authState.status == AuthStatus.loading
                      ? null
                      : _handleRegister,
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: authState.status == AuthStatus.loading
                            ? const SizedBox(
                                key: ValueKey('loading'),
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white))
                            : const Text('Create Account',
                                key: ValueKey('text'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SlideUpFadeIn(
                delay: 600,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',
                        style: TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: const Text('Login',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
