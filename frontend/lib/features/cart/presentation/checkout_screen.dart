import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';
import '../../../core/providers/cart_provider.dart';
import '../../../core/providers/order_provider.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/models/order_models.dart';
import '../../../core/models/user_models.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _currentStep = 0;
  int? _selectedAddressIndex;
  String _paymentMethod = 'COD';
  bool _isPlacingOrder = false;
  final _instructionsController = TextEditingController();

  final _newAddressController = TextEditingController();

  @override
  void dispose() {
    _instructionsController.dispose();
    _newAddressController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    final cart = ref.read(cartProvider.notifier);
    final cartItems = ref.read(cartProvider);
    final pharmacyId = cart.pharmacyId;
    if (pharmacyId == null || cartItems.isEmpty) return;

    String deliveryAddress = 'Default Address';
    final addressesAsync = ref.read(addressesProvider);
    addressesAsync.when(
        data: (addrs) {
          if (_selectedAddressIndex != null &&
              _selectedAddressIndex! < addrs.length) {
            deliveryAddress = addrs[_selectedAddressIndex!].fullAddress;
          } else if (_newAddressController.text.isNotEmpty) {
            deliveryAddress = _newAddressController.text;
          } else if (addrs.isNotEmpty) {
            deliveryAddress = addrs.first.fullAddress;
          }
        },
        loading: () {},
        error: (_, __) {});

    setState(() => _isPlacingOrder = true);

    try {
      final request = CreateOrderRequest(
        pharmacyId: pharmacyId,
        items: cartItems
            .map((e) => OrderItemRequest(
                medicineId: e.medicine.id, quantity: e.quantity))
            .toList(),
        deliveryAddress: deliveryAddress,
        paymentMethod: _paymentMethod,
        specialInstructions: _instructionsController.text.isNotEmpty
            ? _instructionsController.text
            : null,
      );

      final orderService = ref.read(orderServiceProvider);
      final order = await orderService.createOrder(request);
      cart.clear();
      if (mounted) {
        context.go('/order-success/${order.id}');
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isPlacingOrder = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to place order: $e'),
              backgroundColor: AppColors.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cart = ref.read(cartProvider.notifier);
    final addressesAsync = ref.watch(addressesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Stepper indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: AppColors.surface,
            child: Row(
              children: [
                _StepIndicator(
                    label: 'Address', step: 0, current: _currentStep),
                _StepLine(active: _currentStep >= 1),
                _StepIndicator(
                    label: 'Payment', step: 1, current: _currentStep),
                _StepLine(active: _currentStep >= 2),
                _StepIndicator(label: 'Review', step: 2, current: _currentStep),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _currentStep == 0
                  ? _AddressStep(
                      key: const ValueKey(0),
                      addressesAsync: addressesAsync,
                      selectedIndex: _selectedAddressIndex,
                      newAddressController: _newAddressController,
                      onSelect: (i) =>
                          setState(() => _selectedAddressIndex = i),
                    )
                  : _currentStep == 1
                      ? _PaymentStep(
                          key: const ValueKey(1),
                          selected: _paymentMethod,
                          onSelect: (m) => setState(() => _paymentMethod = m),
                        )
                      : _ReviewStep(
                          key: const ValueKey(2),
                          cartItems: cartItems,
                          cart: cart,
                          paymentMethod: _paymentMethod,
                          instructionsController: _instructionsController,
                        ),
            ),
          ),
          // Bottom bar
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -4)),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep--),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: AnimatedScaleButton(
                    onTap: _isPlacingOrder
                        ? null
                        : () {
                            if (_currentStep < 2) {
                              setState(() => _currentStep++);
                            } else {
                              _placeOrder();
                            }
                          },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: _isPlacingOrder
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white))
                            : Text(
                                _currentStep < 2
                                    ? 'Continue'
                                    : 'Place Order — ₹${cart.total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Step 0: Address Selection ---
class _AddressStep extends StatelessWidget {
  final AsyncValue<List<UserAddress>> addressesAsync;
  final int? selectedIndex;
  final TextEditingController newAddressController;
  final ValueChanged<int> onSelect;

  const _AddressStep({
    super.key,
    required this.addressesAsync,
    required this.selectedIndex,
    required this.newAddressController,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          addressesAsync.when(
            data: (addresses) {
              if (addresses.isEmpty) {
                return _noAddresses(context);
              }
              return Column(
                children: addresses.asMap().entries.map((e) {
                  final i = e.key;
                  final addr = e.value;
                  final selected = selectedIndex == i;
                  return SlideUpFadeIn(
                    delay: i * 80,
                    child: GestureDetector(
                      onTap: () => onSelect(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.border,
                              width: selected ? 2 : 1),
                        ),
                        child: Row(
                          children: [
                            Icon(
                                addr.label.toLowerCase().contains('home')
                                    ? Icons.home_rounded
                                    : Icons.business_rounded,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.textSecondary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(addr.label,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 2),
                                  Text(addr.fullAddress,
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                            if (selected)
                              Icon(Icons.check_circle_rounded,
                                  color: AppColors.primary),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _noAddresses(context),
          ),
          const SizedBox(height: 16),
          const Text('Or enter new address',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          TextField(
            controller: newAddressController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Enter full delivery address...',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noAddresses(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(Icons.location_off_rounded,
              size: 40, color: AppColors.textHint.withValues(alpha: 0.3)),
          const SizedBox(height: 8),
          const Text('No saved addresses',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          const Text('Enter your address below'),
        ],
      ),
    );
  }
}

// --- Step 1: Payment Method ---
class _PaymentStep extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;

  const _PaymentStep(
      {super.key, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final methods = [
      {'id': 'COD', 'label': 'Cash on Delivery', 'icon': Icons.money_rounded},
      {
        'id': 'UPI',
        'label': 'UPI / GPay / PhonePe',
        'icon': Icons.account_balance_rounded
      },
      {
        'id': 'CARD',
        'label': 'Credit / Debit Card',
        'icon': Icons.credit_card_rounded
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...methods.asMap().entries.map((e) {
            final m = e.value;
            final active = selected == m['id'];
            return SlideUpFadeIn(
              delay: e.key * 80,
              child: GestureDetector(
                onTap: () => onSelect(m['id'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: active ? AppColors.primary : AppColors.border,
                        width: active ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Icon(m['icon'] as IconData,
                          color: active
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          size: 24),
                      const SizedBox(width: 14),
                      Text(m['label'] as String,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15)),
                      const Spacer(),
                      if (active)
                        Icon(Icons.check_circle_rounded,
                            color: AppColors.primary, size: 22),
                    ],
                  ),
                ),
              ),
            );
          }),
          if (selected != 'COD') ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline_rounded,
                      color: AppColors.warning, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                        'Online payment will be simulated. No real charges.',
                        style:
                            TextStyle(color: AppColors.warning, fontSize: 13)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// --- Step 2: Review ---
class _ReviewStep extends ConsumerWidget {
  final List cartItems;
  final CartNotifier cart;
  final String paymentMethod;
  final TextEditingController instructionsController;

  const _ReviewStep({
    super.key,
    required this.cartItems,
    required this.cart,
    required this.paymentMethod,
    required this.instructionsController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          // Items
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                if (cart.pharmacyName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Icon(Icons.local_pharmacy_rounded,
                            color: AppColors.success, size: 18),
                        const SizedBox(width: 8),
                        Text(cart.pharmacyName!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                  ),
                ...cartItems.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                '${item.medicine.name} × ${item.quantity}',
                                style: const TextStyle(fontSize: 14)),
                          ),
                          Text('₹${item.totalPrice.toStringAsFixed(2)}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    )),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',
                        style: TextStyle(color: AppColors.textSecondary)),
                    Text('₹${cart.subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery Fee',
                        style: TextStyle(color: AppColors.textSecondary)),
                    Text('₹${cart.deliveryFee.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    Text('₹${cart.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Payment badge
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(Icons.payment_rounded, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Text('Payment: $paymentMethod',
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Special instructions
          TextField(
            controller: instructionsController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Special instructions (optional)',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String label;
  final int step;
  final int current;
  const _StepIndicator(
      {required this.label, required this.step, required this.current});

  @override
  Widget build(BuildContext context) {
    final active = current >= step;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.primary : AppColors.border,
          ),
          child: Center(
            child: active
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text('${step + 1}',
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                color: active ? AppColors.primary : AppColors.textHint,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool active;
  const _StepLine({required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 16),
        color: active ? AppColors.primary : AppColors.border,
      ),
    );
  }
}
