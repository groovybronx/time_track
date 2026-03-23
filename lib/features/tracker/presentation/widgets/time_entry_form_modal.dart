import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../data/local/database.dart';
import '../../application/tracker_providers.dart';

class TimeEntryFormModal extends ConsumerStatefulWidget {
  final TimeEntry entry;
  const TimeEntryFormModal({super.key, required this.entry});

  @override
  ConsumerState<TimeEntryFormModal> createState() => _TimeEntryFormModalState();
}

class _TimeEntryFormModalState extends ConsumerState<TimeEntryFormModal> {
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.entry.taskName);
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTheme.glassCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Modifier l'activité",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: "Nom de la tâche",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Début : ${widget.entry.startAt.hour}:${widget.entry.startAt.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await ref
                        .read(trackerControllerProvider)
                        .removeEntry(widget.entry.id);
                    if (!mounted) {
                      return;
                    }
                    navigator.pop();
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                  ),
                  label: const Text(
                    "SUPPRIMER",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    await ref
                        .read(trackerControllerProvider)
                        .updateEntry(
                          widget.entry.copyWith(taskName: _taskController.text),
                        );
                    if (!mounted) {
                      return;
                    }
                    navigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("ENREGISTRER"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
