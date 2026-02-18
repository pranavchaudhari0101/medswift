import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class MainShell extends StatefulWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<AnimationController> _bounceControllers;
  late List<Animation<double>> _bounceAnimations;

  static const _routes = ['/home', '/search', '/orders', '/profile'];

  @override
  void initState() {
    super.initState();
    _bounceControllers = List.generate(
      4,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    _bounceAnimations = _bounceControllers.map((c) {
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.25), weight: 40),
        TweenSequenceItem(tween: Tween(begin: 1.25, end: 0.9), weight: 30),
        TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 30),
      ]).animate(CurvedAnimation(parent: c, curve: Curves.easeInOut));
    }).toList();
  }

  @override
  void dispose() {
    for (final c in _bounceControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (int i = 0; i < _routes.length; i++) {
      if (location.startsWith(_routes[i])) {
        _selectedIndex = i;
        break;
      }
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                    0, Icons.home_rounded, Icons.home_outlined, 'Home'),
                _buildNavItem(
                    1, Icons.search_rounded, Icons.search_outlined, 'Search'),
                _buildCenterButton(),
                _buildNavItem(2, Icons.receipt_long_rounded,
                    Icons.receipt_long_outlined, 'Orders'),
                _buildNavItem(3, Icons.person_rounded,
                    Icons.person_outline_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData activeIcon, IconData inactiveIcon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        if (_selectedIndex != index) {
          _bounceControllers[index].forward(from: 0);
        }
        setState(() => _selectedIndex = index);
        context.go(_routes[index]);
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _bounceAnimations[index],
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  isSelected ? activeIcon : inactiveIcon,
                  color: isSelected ? AppColors.primary : AppColors.textHint,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textHint,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => context.push('/prescription/upload'),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.9, end: 1.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.elasticOut,
        builder: (context, value, child) =>
            Transform.scale(scale: value, child: child),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.document_scanner_rounded,
              color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
