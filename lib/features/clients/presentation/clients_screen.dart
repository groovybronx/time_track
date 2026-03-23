import 'package:flutter/material.dart'; // Corrigé ici (plus de iimport)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatter_service.dart';
import '../application/clients_providers.dart'; // Chemin corrigé (../../)
import 'widgets/client_form_modal.dart';
import '../../../data/local/database.dart';

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(clientsListProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Clients',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _openClientModal(context),
                  icon: const Icon(Icons.add),
                  label: const Text("AJOUTER UN CLIENT"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Liste des clients (Réactive)
            Expanded(
              child: clientsAsync.when(
                data: (clients) => clients.isEmpty
                    ? _buildEmptyState(context)
                    : _buildClientGrid(context, clients, ref),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Erreur: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // État vide si aucun client en base
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 80, color: AppTheme.primary.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(
            "Aucun client pour le moment",
            style: TextStyle(color: AppTheme.primary.withOpacity(0.5), fontSize: 18),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => _openClientModal(context),
            child: const Text("Créer votre premier client"),
          ),
        ],
      ),
    );
  }

  // Grille Responsive
  Widget _buildClientGrid(BuildContext context, List<Client> clients, WidgetRef ref) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1, // 3 colonnes sur Mac, 1 sur Mobile
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 180, // Hauteur fixe des cartes
      ),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return _ClientCard(client: client);
      },
    );
  }

  void _openClientModal(BuildContext context, {Client? client}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: ClientFormModal(clientToEdit: client),
      ),
    );
  }
}

// Widget de la Carte Client (Design Glass)
class _ClientCard extends ConsumerWidget {
  final Client client;
  const _ClientCard({required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppTheme.glassCard(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getColorFromToken(client.colorToken),
                  radius: 8,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    client.societe,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Actions CRUD
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () => _editClient(context),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                  onPressed: () => _confirmDelete(context, ref),
                ),
              ],
            ),
            const Spacer(),
            if (client.nomContact != null && client.nomContact!.isNotEmpty)
              Text(
                client.nomContact!,
                style: TextStyle(color: AppTheme.primary.withOpacity(0.6)),
              ),
            const SizedBox(height: 8),
            Text(
              "Tarif : ${FormatterService.formatCurrency(client.tarifHt)}/h",
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.accent),
            ),
          ],
        ),
      ),
    );
  }

  void _editClient(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: ClientFormModal(clientToEdit: client),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Supprimer le client ?"),
        content: Text("Cela supprimera également toutes les prestations liées à ${client.societe}."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("ANNULER")),
          TextButton(
            onPressed: () {
              ref.read(clientsControllerProvider).removeClient(client.id);
              Navigator.pop(context);
            },
            child: const Text("SUPPRIMER", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Color _getColorFromToken(String token) {
  switch (token) {
    case 'blue-500':
      return Colors.blue;
    case 'emerald-500':
      return const Color(0xFF10B981); // Remplace Colors.emerald
    case 'amber-500':
      return Colors.amber;
    case 'rose-500':
      return const Color(0xFFF43F5E); // Remplace Colors.rose
    case 'purple-500':
      return Colors.purple;
    case 'slate-500':
      return const Color(0xFF64748B); // Remplace Colors.slate
    default:
      return Colors.blue;
  }
}
}
