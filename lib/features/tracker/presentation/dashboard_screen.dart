import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../data/local/database.dart';
import '../application/tracker_providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Timer? _ticker;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeEntryAsync = ref.watch(activeEntryProvider);
    final recentEntriesAsync = ref.watch(recentEntriesProvider);

    final activeEntry = activeEntryAsync.valueOrNull;
    final isTracking = activeEntry != null;
    final timerValue = isTracking
        ? _formatDuration(_now.difference(activeEntry.startAt))
        : '00:00:00';
    final taskName = activeEntry?.taskName ?? 'Aucune prestation active';
    final clientName = activeEntry?.clientName ?? '—';

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
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.primary.withValues(alpha: 0.55),
            ),
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
                          color: isTracking ? AppTheme.danger : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isTracking
                            ? 'Prestation en cours'
                            : 'Aucune prestation active',
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
                            timerValue,
                            style: const TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w200,
                              color: AppTheme.primary,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$taskName  ·  $clientName',
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
                        onPressed: activeEntryAsync.isLoading
                            ? null
                            : () async {
                                final controller = ref.read(
                                  trackerControllerProvider,
                                );
                                await controller.toggleTracking(activeEntry: activeEntry);
                              },
                        icon: Icon(
                          isTracking
                              ? Icons.stop_rounded
                              : Icons.play_arrow_rounded,
                          size: 26,
                        ),
                        label: Text(
                          isTracking
                              ? 'ARRÊTER LA PRESTATION'
                              : 'DÉMARRER UNE PRESTATION',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: isTracking
                              ? AppTheme.danger
                              : AppTheme.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
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
          LayoutBuilder(
            builder: (context, constraints) {
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
                    value: 'Connecté DB',
                    icon: Icons.schedule_rounded,
                    color: AppTheme.accent,
                  ),
                  _KpiCard(
                    label: 'Ce mois',
                    value: 'SQLite live',
                    icon: Icons.calendar_today_rounded,
                    color: Color(0xFF009688),
                  ),
                  _KpiCard(
                    label: 'Prestations actives',
                    value: '1 max',
                    icon: Icons.people_rounded,
                    color: Color(0xFFFF9800),
                  ),
                ],
              );
            },
          ),
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
          recentEntriesAsync.when(
            data: (entries) {
              if (entries.isEmpty) {
                return AppTheme.glassCard(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    child: Text(
                      'Aucune prestation enregistrée pour le moment.',
                      style: TextStyle(color: AppTheme.primary),
                    ),
                  ),
                );
              }

              return Column(
                children: entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _PrestationListTile(entry: entry),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, _) => AppTheme.glassCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Text(
                  'Erreur de lecture SQLite : $error',
                  style: const TextStyle(color: AppTheme.danger),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
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
        padding: const EdgeInsets.all(16.0),
        child: Row( // C'est cette ligne qui déborde
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 12),
            Expanded( // AJOUTE CECI : Force le texte à rester dans les limites
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label,
                    style: TextStyle(color: AppTheme.primary.withOpacity(0.7), fontSize: 12),
                    overflow: TextOverflow.ellipsis, // Coupe proprement si trop long
                  ),
                  Text(value,
                    style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _PrestationListTile extends StatelessWidget {
  const _PrestationListTile({required this.entry});

  final TimeEntry entry;

  @override
  Widget build(BuildContext context) {
    final themeColor = entry.endAt == null ? AppTheme.danger : AppTheme.accent;
    final duration = (entry.endAt ?? DateTime.now()).difference(entry.startAt);

    return AppTheme.glassCard(
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: themeColor, width: 4)),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.taskName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.clientName ?? '—',
                  style: TextStyle(
                    color: AppTheme.primary.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatDurationCompact(duration),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: entry.endAt == null
                        ? AppTheme.danger
                        : AppTheme.primary,
                    fontSize: 16,
                  ),
                ),
                Text(
                  _formatDate(entry.startAt),
                  style: TextStyle(
                    color: AppTheme.primary.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDurationCompact(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours == 0) {
      return '${minutes}m';
    }

    return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('EEE d MMM · HH:mm', 'fr_FR');
    return formatter.format(date);
  }
}
