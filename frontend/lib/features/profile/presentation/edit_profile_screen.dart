import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Rajesh Kumar');
  final _emailController = TextEditingController(text: 'rajesh@email.com');
  final _phoneController = TextEditingController(text: '9999999999');
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SlideUpFadeIn(
              delay: 0,
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text('R',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.camera_alt_rounded,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SlideUpFadeIn(
              delay: 100,
              child: _buildField(
                  'Full Name', _nameController, Icons.person_outline_rounded),
            ),
            const SizedBox(height: 20),
            SlideUpFadeIn(
              delay: 200,
              child: _buildField(
                  'Email', _emailController, Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress),
            ),
            const SizedBox(height: 20),
            SlideUpFadeIn(
              delay: 300,
              child: _buildField(
                  'Phone Number', _phoneController, Icons.phone_android_rounded,
                  keyboardType: TextInputType.phone, prefix: '+91 '),
            ),
            const SizedBox(height: 20),
            SlideUpFadeIn(
              delay: 400,
              child: _buildField(
                  'Date of Birth',
                  TextEditingController(text: '15/06/1990'),
                  Icons.calendar_today_rounded,
                  enabled: false),
            ),
            const SizedBox(height: 20),
            SlideUpFadeIn(
              delay: 500,
              child: _buildField('Gender', TextEditingController(text: 'Male'),
                  Icons.wc_rounded,
                  enabled: false),
            ),
            const SizedBox(height: 32),
            SlideUpFadeIn(
              delay: 600,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleSave,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _isSaving
                        ? const SizedBox(
                            key: ValueKey('saving'),
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('Save Changes', key: ValueKey('save')),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
      String label, TextEditingController controller, IconData icon,
      {TextInputType? keyboardType, String? prefix, bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            prefixText: prefix,
          ),
        ),
      ],
    );
  }

  void _handleSave() {
    setState(() => _isSaving = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile updated successfully'),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
