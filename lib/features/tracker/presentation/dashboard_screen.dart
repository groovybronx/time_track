import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // ── Mock state ──────────────────────────────────────────────────────────────
  bool _isTracking = true;
  final String _timerValue = '00:04:32';
  final String _taskName = 'Installation Réseau';
  final String _clientName = 'Client Martin';

  static const List<_MockPrestation> _prestations = [
    _MockPrestation(
      task: 'Configuration serveur',
      client: 'Client Martin',
      duration: '2h 15m',
      date: 'Lundi 22 mars',
      color: Color(0xFF0077CC),
    ),
    _MockPrestation(
      task: 'Réunion de suivi',
      client: 'Client Dupont',
      duration: '45m',
      date: 'Vendredi 19 mars',
      color: Color(0xFF009688),
    ),
    _MockPrestation(
      task: 'Développement API',
      client: 'Client Lambert',
      duration: '3h 00m',
      date: 'Jeudi 18 mars',
      color: Color(0xFFFF9800),
    ),
  ];
  // ────────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── En-tête ─────────────────────────────────────────────────────────
          Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Dimanche 22 mars 2026',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.primary.withValues(alpha: 0.55)),
          ),
          const SizedBox(height: 32),

          // ── Carte Tracker ────────────────────────────────────────────────────
          AppTheme.glassCard(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Indicateur animé
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _isTracking ? AppTheme.danger : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _isTracking ? 'Prestation en cours' : 'Aucune prestation active',
                        style: TextStyle(
                          color: AppTheme.primary.withValues(alpha: 0.65),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _timerValue,
                            style: const TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w200,
                              color: AppTheme.primary,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$_taskName  ·  $_clientName',
                            style: TextStyle(
                              color: AppTheme.primary.withValues(alpha: 0.7),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Bouton START / STOP fusionné
                      FilledButton.icon(
                        onPressed: () =>
                            setState(() => _isTracking = !_isTracking),
                        icon: Icon(
                          _isTracking
                              ? Icons.stop_rounded
                              : Icons.play_arrow_rounded,
                          size: 26,
                        ),
                        label: Text(
                          _isTracking
                              ? 'ARRÊTER LA PRESTATION'
                              : 'DÉMARRER UNE PRESTATION',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: _isTracking
                              ? AppTheme.danger
                              : AppTheme.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // ── KPI Cards ────────────────────────────────────────────────────────
          LayoutBuilder(builder: (context, constraints) {
            final crossAxis = constraints.maxWidth > 600 ? 3 : 1;
            return GridView.count(
              crossAxisCount: crossAxis,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
              children: const [
                _KpiCard(
                    label: 'Cette semaine',
                    value: '14h 30m',
                    icon: Icons.schedule_rounded,
                    color: AppTheme.accent),
                _KpiCard(
                    label: 'Ce mois',
                    value: '62h 15m',
                    icon: Icons.calendar_today_rounded,
                    color: Color(0xFF009688)),
                _KpiCard(
                    label: 'Prestations actives',
                    value: '3 clients',
                    icon: Icons.people_rounded,
                    color: Color(0xFFFF9800)),
              ],
            );
          }),
          const SizedBox(height: 32),

          // ── Dernières prestations ─────────────────────────────────────────────
          Text(
            'Dernières prestations',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          ..._prestations.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PrestationListTile(prestation: p),
              )),
        ],
      ),
    );
  }
}

// ── Widgets internes ────────────────────────────────────────────────────────────

class _KpiCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _KpiCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppTheme.glassCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary)),
                Text(label,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.primary.withValues(alpha: 0.55))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MockPrestation {
  final String task;
  final String client;
  final String duration;
  final String date;
  final Color color;

  const _MockPrestation({
    required this.task,
    required this.client,
    required this.duration,
    required this.date,
    required this.color,
  });
}

class _PrestationListTile extends StatelessWidget {
  final _MockPrestation prestation;

  const _PrestationListTile({required this.prestation});

  @override
  Widget build(BuildContext context) {
    return AppTheme.glassCard(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(color: prestation.color, width: 4)),
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(prestation.task,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary)),
                const SizedBox(height: 2),
                Text(prestation.client,
                    style: TextStyle(
                        color: AppTheme.primary.withValues(alpha: 0.6),
                        fontSize: 13)),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(prestation.duration,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                        fontSize: 16)),
                Text(prestation.date,
                    style: TextStyle(
                        color: AppTheme.primary.withValues(alpha: 0.5),
                        fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
