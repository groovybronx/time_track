import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/tracker/presentation/dashboard_screen.dart';
import 'features/agenda/presentation/agenda_screen.dart';
import 'features/clients/presentation/clients_screen.dart';
import 'features/settings/presentation/settings_screen.dart';
import 'features/stats/presentation/stats_screen.dart';
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    DashboardScreen(),
    AgendaScreen(),
    ClientsScreen(),
    StatsScreen(),
    SettingsScreen(),
  ];

  static const List<_NavItem> _navItems = [
    _NavItem(icon: Icons.dashboard_rounded,       label: 'Dashboard'),
    _NavItem(icon: Icons.calendar_month_rounded,  label: 'Agenda'),
    _NavItem(icon: Icons.people_rounded,          label: 'Clients'),
    _NavItem(icon: Icons.bar_chart_rounded,       label: 'Stats'),
    _NavItem(icon: Icons.settings_rounded,        label: 'Paramètres'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: Stack(
        children: [
          // ── Fond dégradé ──────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE0F7FA), Color(0xFFFFFDE7)],
              ),
            ),
          ),

          // ── Layout responsive ─────────────────────────────────────────────
          Row(
            children: [
              // Sidebar desktop
              if (isDesktop)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (i) =>
                      setState(() => _selectedIndex = i),
                  extended: true,
                  backgroundColor:
                      AppTheme.primary.withValues(alpha: 0.04),
                  unselectedIconTheme:
                      const IconThemeData(color: AppTheme.primary),
                  selectedIconTheme:
                      const IconThemeData(color: AppTheme.accent),
                  unselectedLabelTextStyle:
                      const TextStyle(color: AppTheme.primary),
                  selectedLabelTextStyle: const TextStyle(
                      color: AppTheme.accent, fontWeight: FontWeight.bold),
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: _AppLogo(),
                  ),
                  destinations: _navItems
                      .map((item) => NavigationRailDestination(
                            icon: Icon(item.icon),
                            label: Text(item.label),
                          ))
                      .toList(),
                ),

              // Zone de contenu principale
              Expanded(child: _screens[_selectedIndex]),
            ],
          ),
        ],
      ),

      // Bottom navigation mobile (Material 3)
      bottomNavigationBar: !isDesktop
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) =>
                  setState(() => _selectedIndex = i),
              indicatorColor: AppTheme.accent.withValues(alpha: 0.15),
              destinations: _navItems
                  .take(3) // Seulement 3 items en mode mobile
                  .map((item) => NavigationDestination(
                        icon: Icon(item.icon),
                        label: item.label,
                      ))
                  .toList(),
            )
          : null,
    );
  }
}

// ─── Modèle interne ────────────────────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

// ─── Logo de l'application ────────────────────────────────────────────────────
class _AppLogo extends StatelessWidget {
  const _AppLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppTheme.accent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.access_time_rounded,
              color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        const Text(
          'TimeTrack',
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
