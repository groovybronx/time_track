import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.settings_rounded, size: 64, color: AppTheme.primary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Text('Paramètres', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.primary)),
          const SizedBox(height: 8),
          Text('À venir — Phase suivante', style: TextStyle(color: AppTheme.primary.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
