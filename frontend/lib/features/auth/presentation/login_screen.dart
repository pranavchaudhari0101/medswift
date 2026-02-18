import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    if (phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    ref.read(authProvider.notifier).login(phone, password);
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),
              // Logo with pulsing shadow
              SlideUpFadeIn(
                delay: 0,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.2, end: 0.4),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: value),
                            blurRadius: 12 + (value * 30),
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.local_pharmacy_rounded,
                          color: Colors.white, size: 34),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SlideUpFadeIn(
                delay: 100,
                child: Text('MedSwift',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
              ),
              SlideUpFadeIn(
                delay: 100,
                child: Text('Your trusted medicine delivery partner',
                    style: TextStyle(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: 48),
              // Phone field
              SlideUpFadeIn(
                delay: 200,
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon:
                        const Icon(Icons.phone_android_rounded, size: 20),
                    prefixText: '+91 ',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password field
              SlideUpFadeIn(
                delay: 300,
                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon:
                        const Icon(Icons.lock_outline_rounded, size: 20),
                    suffixIcon: IconButton(
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          key: ValueKey(_obscurePassword),
                          size: 20,
                        ),
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: const Text('Forgot Password?')),
              ),
              const SizedBox(height: 16),
              // Login button
              SlideUpFadeIn(
                delay: 400,
                child: AnimatedScaleButton(
                  onTap: authState.status == AuthStatus.loading
                      ? null
                      : _handleLogin,
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
                            : const Text('Login',
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
              const SizedBox(height: 32),
              SlideUpFadeIn(
                delay: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: TextStyle(color: AppColors.textSecondary)),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: const Text('Register',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
