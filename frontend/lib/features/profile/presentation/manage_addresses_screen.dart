import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';

class ManageAddressesScreen extends StatelessWidget {
  const ManageAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = [
      _Address('Home', '42, Koramangala 4th Block, Bangalore - 560034', true,
          Icons.home_rounded),
      _Address('Office', 'WeWork Galaxy, Residency Road, Bangalore - 560025',
          false, Icons.business_rounded),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Addresses')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('Add Address',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
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
                  Icon(Icons.location_on_rounded, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                        'Delivery is available at your saved addresses in Bangalore.',
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...addresses.asMap().entries.map((e) {
            return SlideUpFadeIn(
              delay: 100 + (e.key * 100),
              child: _buildAddressCard(context, e.value),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, _Address addr) {
    return AnimatedScaleButton(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(addr.icon, color: AppColors.primary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(addr.label,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            if (addr.isDefault) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.success.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('Default',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(addr.address,
                            style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                                height: 1.4)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.edit_outlined,
                        size: 16, color: AppColors.primary),
                    label: Text('Edit',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outline_rounded,
                        size: 16, color: AppColors.error),
                    label: Text('Delete',
                        style: TextStyle(color: AppColors.error)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Address {
  final String label, address;
  final bool isDefault;
  final IconData icon;
  _Address(this.label, this.address, this.isDefault, this.icon);
}
