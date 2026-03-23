import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../../../core/theme/app_theme.dart';
import '../../application/clients_providers.dart';
import '../../../../data/local/database.dart';

class ClientFormModal extends ConsumerStatefulWidget {
  final Client? clientToEdit;

  const ClientFormModal({super.key, this.clientToEdit});

  @override
  ConsumerState<ClientFormModal> createState() => _ClientFormModalState();
}

class _ClientFormModalState extends ConsumerState<ClientFormModal> {
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs de texte
  late TextEditingController _societeController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _tarifController;

  String _selectedColor = 'blue-500';

  // Couleurs disponibles (en phase avec les tokens Tailwind/AppTheme)


  final List<String> _availableColors = [
    'blue-500',
    'emerald-500',
    'amber-500',
    'rose-500',
    'purple-500',
    'slate-500'
  ];

  @override
  void initState() {
    super.initState();
    // Initialisation avec les données existantes si on est en mode "Edition"
    _societeController = TextEditingController(text: widget.clientToEdit?.societe);
    _contactController = TextEditingController(text: widget.clientToEdit?.nomContact);
    _emailController = TextEditingController(text: widget.clientToEdit?.email);
    _tarifController = TextEditingController(
      text: widget.clientToEdit != null ? widget.clientToEdit!.tarifHt.toString() : "",
    );
    _selectedColor = widget.clientToEdit?.colorToken ?? 'blue-500';
  }

  @override
  void dispose() {
    _societeController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _tarifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // On utilise le glassCard du thème pour maintenir l'esthétique
    return AppTheme.glassCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.clientToEdit == null ? "Nouveau Client" : "Modifier Client",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Champ Société
                _buildFieldLabel("Nom de la société *"),
                TextFormField(
                  controller: _societeController,
                  decoration: const InputDecoration(hintText: "Ex: Acme Corp"),
                  validator: (value) => (value == null || value.isEmpty) ? "Le nom est requis" : null,
                ),
                const SizedBox(height: 16),

                // Champ Contact
                _buildFieldLabel("Nom du contact"),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(hintText: "Ex: Jean Dupont"),
                ),
                const SizedBox(height: 16),

                // Champ Tarif HT
                _buildFieldLabel("Tarif Horaire HT (€)"),
                TextFormField(
                  controller: _tarifController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: "0.00",
                    suffixText: "€ / h",
                  ),
                ),
                const SizedBox(height: 24),

                // Sélecteur de couleur
                _buildFieldLabel("Couleur d'identification"),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _availableColors.map((colorToken) {
                    final isSelected = _selectedColor == colorToken;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = colorToken),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: _getColorFromToken(colorToken),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? AppTheme.primary : Colors.white.withValues(alpha: 0.5),
                            width: isSelected ? 3 : 1,
                          ),
                          boxShadow: isSelected ? [
                            BoxShadow(
                              color: _getColorFromToken(colorToken).withValues(alpha: 0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ] : [],
                        ),
                        child: isSelected
                          ? const Icon(Icons.check, color: Colors.white, size: 20)
                          : null,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 40),

                // Boutons d'action
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("ANNULER", style: TextStyle(color: AppTheme.primary.withValues(alpha: 0.6))),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      child: Text(widget.clientToEdit == null ? "CRÉER" : "METTRE À JOUR"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          color: AppTheme.primary.withValues(alpha: 0.7),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(clientsControllerProvider);
    final double tarif = double.tryParse(_tarifController.text) ?? 0.0;

    if (widget.clientToEdit == null) {
      // MODE CRÉATION
      await controller.addClient(
        societe: _societeController.text,
        nomContact: _contactController.text,
        tarifHt: tarif,
        colorToken: _selectedColor,
      );
    } else {
      // MODE ÉDITION
      final updatedClient = widget.clientToEdit!.copyWith(
        societe: _societeController.text,
        nomContact: drift.Value(_contactController.text),
        tarifHt: tarif,
        colorToken: _selectedColor,
      );
      await controller.updateClient(updatedClient);
    }

    if (mounted) Navigator.pop(context);
  }

  // Helper pour mapper les tokens aux vraies couleurs Flutter
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