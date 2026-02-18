import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _controller = PageController();
  int _currentPage = 0;

  late AnimationController _iconPulse;
  late Animation<double> _iconScale;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.medication_rounded,
      title: 'Your Medicines,\nDelivered Fast',
      subtitle:
          'Get prescriptions delivered to your doorstep in 60 minutes from verified pharmacies near you.',
      color: AppColors.primary,
    ),
    _OnboardingPage(
      icon: Icons.compare_arrows_rounded,
      title: 'Compare Prices\nAcross Pharmacies',
      subtitle:
          'See prices from multiple pharmacies and choose the best deal. Always transparent, zero delivery charges.',
      color: AppColors.success,
    ),
    _OnboardingPage(
      icon: Icons.notifications_active_rounded,
      title: 'Never Miss\nA Refill',
      subtitle:
          'Set up automated refills and medication reminders. We\'ll take care of your health routine.',
      color: AppColors.secondary,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _iconPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _iconScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _iconPulse, curve: Curves.easeInOut),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _iconPulse.dispose();
    _fadeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                  _fadeController.reset();
                  _fadeController.forward();
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return FadeTransition(
                    opacity: _fadeAnim,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTransition(
                            scale: _iconScale,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    page.color.withValues(alpha: 0.15),
                                    page.color.withValues(alpha: 0.05),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: page.color.withValues(alpha: 0.2),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child:
                                  Icon(page.icon, size: 64, color: page.color),
                            ),
                          ),
                          const SizedBox(height: 48),
                          Text(
                            page.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(height: 1.2),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.textSecondary,
                                      height: 1.5,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: _currentPage == index ? 32 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          context.go('/login');
                        } else {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Get Started'
                              : 'Next',
                          key: ValueKey(_currentPage),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}
