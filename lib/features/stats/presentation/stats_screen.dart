import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Text(
          'Statistiques & Rapports\n(Bientôt disponible)',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.primary, fontSize: 18),
        ),
      ),
    );
  }
}