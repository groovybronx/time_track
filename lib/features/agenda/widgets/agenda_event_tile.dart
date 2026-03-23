import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/collision_helper.dart';
import '../../../../core/utils/formatter_service.dart';

class AgendaEventTile extends ConsumerWidget {
  final PositionedTimeEntry positionedEntry;
  final VoidCallback? onTap;

  const AgendaEventTile({
    super.key,
    required this.positionedEntry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entry = positionedEntry.data.entry;
    final client = positionedEntry.data.client; // Client est ici de type Client?

    final duration = (entry.endAt ?? DateTime.now()).difference(entry.startAt);

    return GestureDetector(
      onTap: onTap,
      child: AppTheme.glassCard(
        // CORRECTION : Utilisation de ?. et ?? pour la sécurité nulle
        bgColor: _getColorFromToken(client?.colorToken ?? 'slate-500').withOpacity(0.15),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: _getColorFromToken(client?.colorToken ?? 'slate-500'),
                width: 4,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.taskName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, height: 1.2),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                // CORRECTION : Affichage d'un texte par défaut si pas de client
                client?.societe ?? 'Sans client',
                style: TextStyle(fontSize: 9, color: AppTheme.primary.withOpacity(0.7)),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    FormatterService.formatDuration(duration),
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorFromToken(String token) {
    switch (token) {
      case 'blue-500': return Colors.blue;
      case 'emerald-500': return const Color(0xFF10B981);
      case 'amber-500': return Colors.amber;
      case 'rose-500': return const Color(0xFFF43F5E);
      case 'purple-500': return Colors.purple;
      case 'slate-500': return const Color(0xFF64748B);
      default: return Colors.blue;
    }
  }
}