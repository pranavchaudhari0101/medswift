import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/staggered_animation.dart';
import '../../../core/widgets/animated_scale_button.dart';

class MedicineRemindersScreen extends StatelessWidget {
  const MedicineRemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reminders = [
      _Reminder('Metformin 500mg', '08:00 AM', 'After Breakfast', true,
          AppColors.primary),
      _Reminder('Amlodipine 5mg', '09:00 AM', 'Before Breakfast', true,
          AppColors.success),
      _Reminder('Pantoprazole 40mg', '01:00 PM', 'Before Lunch', true,
          const Color(0xFFF59E0B)),
      _Reminder('Metformin 500mg', '09:00 PM', 'After Dinner', false,
          AppColors.primary),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine Reminders')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_alarm_rounded, color: Colors.white),
        label: const Text('Add Reminder',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SlideUpFadeIn(
            delay: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today\'s Progress',
                            style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 14)),
                        const SizedBox(height: 4),
                        const Text('3 of 4 taken',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.75,
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.medical_services_rounded,
                      size: 56, color: Colors.white.withValues(alpha: 0.3)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SlideUpFadeIn(
            delay: 100,
            child: Text('Today\'s Schedule',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 12),
          ...reminders.asMap().entries.map((e) {
            return SlideUpFadeIn(
              delay: 150 + (e.key * 80),
              child: _buildReminderCard(e.value),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildReminderCard(_Reminder r) {
    return AnimatedScaleButton(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: r.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  r.taken ? Icons.check_circle_rounded : Icons.alarm_rounded,
                  color: r.taken ? AppColors.success : r.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            decoration:
                                r.taken ? TextDecoration.lineThrough : null,
                            color: r.taken
                                ? AppColors.textHint
                                : AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded,
                            size: 14, color: AppColors.textHint),
                        const SizedBox(width: 4),
                        Text(r.time,
                            style: TextStyle(
                                fontSize: 13, color: AppColors.textSecondary)),
                        const SizedBox(width: 8),
                        Text('• ${r.instruction}',
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textHint)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!r.taken)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Take',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Reminder {
  final String name, time, instruction;
  final bool taken;
  final Color color;
  _Reminder(this.name, this.time, this.instruction, this.taken, this.color);
}
