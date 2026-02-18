import 'package:flutter/material.dart';

/// Reusable staggered slide-up + fade-in animation.
/// Wrap any widget in this, provide a [delay] to stagger siblings.
class SlideUpFadeIn extends StatefulWidget {
  final Widget child;
  final int delay;
  final Duration duration;
  final double offsetY;

  const SlideUpFadeIn({
    super.key,
    required this.child,
    this.delay = 0,
    this.duration = const Duration(milliseconds: 500),
    this.offsetY = 30,
  });

  @override
  State<SlideUpFadeIn> createState() => _SlideUpFadeInState();
}

class _SlideUpFadeInState extends State<SlideUpFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _offset = Tween<Offset>(
      begin: Offset(0, widget.offsetY),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(offset: _offset.value, child: child),
      ),
      child: widget.child,
    );
  }
}
