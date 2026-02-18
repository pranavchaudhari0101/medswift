import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/medicine/presentation/medicine_search_screen.dart';
import '../../features/medicine/presentation/medicine_detail_screen.dart';
import '../../features/pharmacy/presentation/pharmacy_list_screen.dart';
import '../../features/prescription/presentation/prescription_upload_screen.dart';
import '../../features/order/presentation/order_history_screen.dart';
import '../../features/order/presentation/order_tracking_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../features/profile/presentation/manage_addresses_screen.dart';
import '../../features/profile/presentation/notifications_screen.dart';
import '../../features/profile/presentation/medicine_reminders_screen.dart';
import '../../features/profile/presentation/help_support_screen.dart';
import '../../features/profile/presentation/about_screen.dart';
import '../../features/home/presentation/main_shell.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/cart/presentation/checkout_screen.dart';
import '../../features/cart/presentation/order_success_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static CustomTransitionPage _fadeSlidePage(
      Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved =
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const OnboardingScreen(), state),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const LoginScreen(), state),
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const RegisterScreen(), state),
      ),

      // Main shell with bottom navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const MedicineSearchScreen(),
          ),
          GoRoute(
            path: '/orders',
            builder: (context, state) => const OrderHistoryScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Full-screen routes with custom transitions
      GoRoute(
        path: '/medicine/:id',
        pageBuilder: (context, state) => _fadeSlidePage(
          MedicineDetailScreen(
              medicineId: state.pathParameters['id']!),
          state,
        ),
      ),
      GoRoute(
        path: '/pharmacies',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const PharmacyListScreen(), state),
      ),
      GoRoute(
        path: '/prescription/upload',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const PrescriptionUploadScreen(), state),
      ),
      GoRoute(
        path: '/order/:id',
        pageBuilder: (context, state) => _fadeSlidePage(
          OrderTrackingScreen(orderId: int.parse(state.pathParameters['id']!)),
          state,
        ),
      ),

      // Cart & Checkout routes
      GoRoute(
        path: '/cart',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const CartScreen(), state),
      ),
      GoRoute(
        path: '/checkout',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const CheckoutScreen(), state),
      ),
      GoRoute(
        path: '/order-success/:id',
        pageBuilder: (context, state) => _fadeSlidePage(
          OrderSuccessScreen(orderId: state.pathParameters['id']!),
          state,
        ),
      ),

      // Profile sub-routes
      GoRoute(
        path: '/profile/edit',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const EditProfileScreen(), state),
      ),
      GoRoute(
        path: '/profile/addresses',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const ManageAddressesScreen(), state),
      ),
      GoRoute(
        path: '/edit-profile',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const EditProfileScreen(), state),
      ),
      GoRoute(
        path: '/addresses',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const ManageAddressesScreen(), state),
      ),
      GoRoute(
        path: '/notifications',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const NotificationsScreen(), state),
      ),
      GoRoute(
        path: '/medicine-reminders',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const MedicineRemindersScreen(), state),
      ),
      GoRoute(
        path: '/help',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const HelpSupportScreen(), state),
      ),
      GoRoute(
        path: '/about',
        pageBuilder: (context, state) =>
            _fadeSlidePage(const AboutScreen(), state),
      ),
    ],
  );
}
