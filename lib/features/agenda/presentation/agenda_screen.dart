import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/collision_helper.dart';
import '../../../main.dart';
import '../../../data/local/database.dart';
import '../widgets/agenda_event_tile.dart';
import '../../tracker/presentation/widgets/time_entry_form_modal.dart';

// 1. On garde la date sélectionnée
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

// 2. NOUVEAU : On crée un provider GLOBAL qui filtre les prestations par semaine
// On utilise .family pour pouvoir lui passer les dates de début et de fin
final weeklyPrestationsProvider =
    StreamProvider.family<List<TimeEntryWithClient>, DateTimeRange>((
      ref,
      range,
    ) {
      final db = ref.watch(databaseProvider);

      return db.watchPrestationsWithClient().map((list) {
        // On filtre ici les prestations qui appartiennent à la semaine affichée
        return list.where((item) {
          return item.entry.startAt.isAfter(
                range.start.subtract(const Duration(seconds: 1)),
              ) &&
              item.entry.startAt.isBefore(range.end);
        }).toList();
      });
    });

class AgendaScreen extends ConsumerWidget {
  const AgendaScreen({super.key});

  static const double hourHeight = 60.0;
  static const double timeWidth = 60.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    // Calcul de la plage de la semaine
    final startOfWeek = selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    final range = DateTimeRange(start: startOfWeek, end: endOfWeek);

    // 3. On écoute le provider global avec la range calculée
    final prestationsAsync = ref.watch(weeklyPrestationsProvider(range));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          _buildHeader(context, ref, selectedDate, startOfWeek),
          Expanded(
            child: prestationsAsync.when(
              data: (entries) =>
                  _buildCalendarGrid(context, startOfWeek, entries),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                debugPrint('Erreur Agenda: $err');
                return Center(child: Text('Erreur: $err'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    DateTime selected,
    DateTime start,
  ) {
    final monthLabel = DateFormat.yMMMM('fr_FR').format(selected);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Text(
            monthLabel.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => ref.read(selectedDateProvider.notifier).state =
                selected.subtract(const Duration(days: 7)),
          ),
          TextButton(
            onPressed: () =>
                ref.read(selectedDateProvider.notifier).state = DateTime.now(),
            child: const Text("AUJOURD'HUI"),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => ref.read(selectedDateProvider.notifier).state =
                selected.add(const Duration(days: 7)),
          ),
        ],
      ),
    );
  }

  // CORRECTION : Type de paramètre mis à jour
  Widget _buildCalendarGrid(
    BuildContext context,
    DateTime startOfWeek,
    List<TimeEntryWithClient> entries,
  ) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: timeWidth),
            ...List.generate(7, (index) {
              final day = startOfWeek.add(Duration(days: index));
              final isToday = DateUtils.isSameDay(day, DateTime.now());
              return Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        DateFormat.E('fr_FR').format(day).toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: isToday ? AppTheme.accent : Colors.grey,
                        ),
                      ),
                      Text(
                        day.day.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isToday ? AppTheme.accent : AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                _buildTimeGrid(),
                _buildEvents(
                  startOfWeek,
                  entries,
                ), // On passe la liste corrigée
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeGrid() {
    return Column(
      children: List.generate(
        24,
        (hour) => Container(
          height: hourHeight,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: timeWidth,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  "$hour:00",
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }

  // CORRECTION : Type de paramètre et logique de filtrage mis à jour
  Widget _buildEvents(DateTime startOfWeek, List<TimeEntryWithClient> entries) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dayWidth = (constraints.maxWidth - timeWidth) / 7;
        List<Widget> eventWidgets = [];

        for (int i = 0; i < 7; i++) {
          final day = startOfWeek.add(Duration(days: i));
          // CORRECTION : On filtre sur item.entry.startAt
          final dayEntries = entries
              .where((item) => DateUtils.isSameDay(item.entry.startAt, day))
              .toList();

          final positionedEntries = CollisionHelper.getPositionedEntries(
            dayEntries,
            hourHeight,
          );

          for (var pe in positionedEntries) {
            eventWidgets.add(
              Positioned(
                top: pe.top,
                height: pe.height,
                left: timeWidth + (i * dayWidth) + (pe.left * dayWidth),
                width: pe.width * dayWidth - 2,
                child: AgendaEventTile(
                  positionedEntry: pe,
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero,
                      content: TimeEntryFormModal(entry: pe.data.entry),
                    ),
                  ),
                ),
              ),
            );
          }
        }

        return SizedBox(
          height: 24 * hourHeight,
          width: constraints.maxWidth,
          child: Stack(children: eventWidgets),
        );
      },
    );
  }
}
