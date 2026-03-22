import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';

class AgendaScreen extends ConsumerWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glassBg = isDark ? AppTheme.glassBgDark : AppTheme.glassBgLight;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── En-tête ──────────────────────────────────────────────────────
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agenda',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lundi 22 mars 2026',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primary.withValues(alpha: 0.55)),
                    ),
                  ],
                ),
                const Spacer(),
                // Sélecteur de vue (mock)
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'day', label: Text('Jour')),
                    ButtonSegment(value: 'week', label: Text('Semaine')),
                    ButtonSegment(value: 'month', label: Text('Mois')),
                  ],
                  selected: const {'day'},
                  onSelectionChanged: (_) {},
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor:
                        AppTheme.accent.withValues(alpha: 0.15),
                    selectedForegroundColor: AppTheme.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Timeline Mockée ──────────────────────────────────────────────
            Expanded(
              child: ListView(
                children: [
                  _TimeSlot(hour: '09:00'),
                  _PrestationCard(
                    task: 'Maintenance poste de travail',
                    client: 'Client Martin',
                    time: '09:30 – 11:00',
                    duration: '1h 30m',
                    clientColor: const Color(0xFF0077CC),
                    glassBg: glassBg,
                  ),
                  _TimeSlot(hour: '11:00'),
                  _TimeSlot(hour: '12:00'),
                  _PrestationCard(
                    task: 'Réunion Admin',
                    client: 'Usage interne',
                    time: '13:00 – 14:00',
                    duration: '1h 00m',
                    clientColor: const Color(0xFFFF9800),
                    glassBg: glassBg,
                  ),
                  _TimeSlot(hour: '14:00'),
                  _PrestationCard(
                    task: 'Installation Réseau',
                    client: 'Client Dupont',
                    time: '14:30 – 17:00',
                    duration: '2h 30m',
                    clientColor: const Color(0xFF009688),
                    glassBg: glassBg,
                  ),
                  _TimeSlot(hour: '17:00'),
                  _TimeSlot(hour: '18:00'),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showPrestationModal(context),
        label: const Text('+ Ajouter Manuel'),
        icon: const Icon(Icons.add_rounded),
        backgroundColor: AppTheme.accent,
        foregroundColor: Colors.white,
      ),
    );
  }
}

// ─── Widgets internes ──────────────────────────────────────────────────────────

class _TimeSlot extends StatelessWidget {
  final String hour;
  const _TimeSlot({required this.hour});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(hour,
                style: TextStyle(
                    color: AppTheme.primary.withValues(alpha: 0.4),
                    fontSize: 12)),
          ),
          Expanded(
            child: Divider(
                color: AppTheme.primary.withValues(alpha: 0.1), height: 1),
          ),
        ],
      ),
    );
  }
}

class _PrestationCard extends StatelessWidget {
  final String task;
  final String client;
  final String time;
  final String duration;
  final Color clientColor;
  final Color glassBg;

  const _PrestationCard({
    required this.task,
    required this.client,
    required this.time,
    required this.duration,
    required this.clientColor,
    required this.glassBg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AppTheme.glassCard(
        bgColor: glassBg,
        child: Container(
          decoration: BoxDecoration(
            border:
                Border(left: BorderSide(color: clientColor, width: 4)),
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(24)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primary)),
                  const SizedBox(height: 2),
                  Text(client,
                      style: TextStyle(
                          color: AppTheme.primary.withValues(alpha: 0.6),
                          fontSize: 13)),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(time,
                      style: const TextStyle(
                          color: AppTheme.primary, fontSize: 13)),
                  Text(duration,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                          fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Modal : Nouvelle Prestation ─────────────────────────────────────────────

void _showPrestationModal(BuildContext context) {
  bool autoStart = true;
  bool isAutoStop = true;
  String selectedAlert = '+30 min';
  String? selectedClient;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState) => Dialog(
        backgroundColor: Colors.transparent,
        child: AppTheme.glassCard(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Titre ─────────────────────────────────────────────────
                    Row(
                      children: [
                        const Icon(Icons.add_circle_outline_rounded,
                            color: AppTheme.accent),
                        const SizedBox(width: 10),
                        Text(
                          'Nouvelle Prestation',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.close_rounded,
                              color: AppTheme.primary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Champs principaux ─────────────────────────────────────
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Nom de la tâche',
                        prefixIcon: Icon(Icons.work_outline_rounded),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 14),
                    DropdownButtonFormField<String>(
                      initialValue: selectedClient,
                      onChanged: (v) =>
                          setModalState(() => selectedClient = v),
                      decoration: const InputDecoration(
                        labelText: 'Client',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'martin',
                            child: Row(children: [
                              CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(0xFF0077CC)),
                              SizedBox(width: 8),
                              Text('Client Martin'),
                            ])),
                        DropdownMenuItem(
                            value: 'dupont',
                            child: Row(children: [
                              CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(0xFF009688)),
                              SizedBox(width: 8),
                              Text('Client Dupont'),
                            ])),
                        DropdownMenuItem(
                            value: 'lambert',
                            child: Row(children: [
                              CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(0xFFFF9800)),
                              SizedBox(width: 8),
                              Text('Client Lambert'),
                            ])),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ── Date & Heure ──────────────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: _DateTimeField(
                              label: 'Début', value: '22 mars, 10:00'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DateTimeField(
                              label: 'Fin', value: '22 mars, 12:00'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppTheme.accent.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Durée : 02:00',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w300,
                              color: AppTheme.primary),
                        ),
                      ),
                    ),
                    const Divider(height: 28),

                    // ── Automatisations ────────────────────────────────────────
                    Text(
                      'AUTOMATISATIONS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.accent,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),

                    // Switch Auto-Start
                    SwitchListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Auto-Start à l\'heure prévue'),
                      subtitle: const Text('Démarre automatiquement le chrono'),
                      value: autoStart,
                      activeThumbColor: AppTheme.accent,
                      onChanged: (v) =>
                          setModalState(() => autoStart = v),
                    ),
                    const SizedBox(height: 8),

                    // ChoiceChip AUTO-STOP / LIBRE
                    Row(
                      children: [
                        const Text('Mode d\'arrêt : ',
                            style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('⏹ AUTO-STOP'),
                          selected: isAutoStop,
                          selectedColor: AppTheme.danger.withValues(alpha: 0.2),
                          onSelected: (_) =>
                              setModalState(() => isAutoStop = true),
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('▶ LIBRE'),
                          selected: !isAutoStop,
                          selectedColor: AppTheme.accent.withValues(alpha: 0.2),
                          onSelected: (_) =>
                              setModalState(() => isAutoStop = false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Alerte dépassement
                    DropdownButtonFormField<String>(
                      initialValue: selectedAlert,
                      onChanged: (v) =>
                          setModalState(() => selectedAlert = v ?? '+30 min'),
                      decoration: const InputDecoration(
                        labelText: 'Alerte dépassement',
                        prefixIcon: Icon(Icons.notifications_outlined),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'none', child: Text('Pas d\'alerte')),
                        DropdownMenuItem(
                            value: '+15 min', child: Text('+15 min')),
                        DropdownMenuItem(
                            value: '+30 min', child: Text('+30 min')),
                        DropdownMenuItem(
                            value: '+1 h', child: Text('+1 heure')),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // ── Boutons ───────────────────────────────────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('ANNULER'),
                        ),
                        const SizedBox(width: 12),
                        FilledButton(
                          onPressed: () => Navigator.pop(context),
                          style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.accent),
                          child: const Text('VALIDER'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _DateTimeField extends StatelessWidget {
  final String label;
  final String value;
  const _DateTimeField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 2),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    size: 14, color: AppTheme.accent),
                const SizedBox(width: 6),
                Text(value,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                        fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
