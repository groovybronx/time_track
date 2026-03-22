Voici le dossier de conception complet et définitif de l'application **TEMPS-TRACK**. Ce document est structuré pour servir de référence absolue à un développeur ou à une équipe produit.

---

# 📑 DOSSIER DE CONCEPTION : TEMPS-TRACK
**Version :** 1.6 (Définitif) | **Date :** 22 Mars 2026 | **Auteur :** Gemini AI & Utilisateur

---

## 1. VISION & OBJECTIFS
**TEMPS-TRACK** est une solution de gestion du temps "Local-First" destinée aux professionnels (consultants, freelances, artisans) ayant des difficultés à noter leurs interventions en temps réel.

* **Objectif Principal :** Réduire la friction de saisie grâce à un bouton unique et une automatisation intelligente.
* **Philosophie :** Confidentialité totale (données locales), design haut de gamme (Glass Morphism) et évolutivité (Clean Architecture).
* **Plateformes :** macOS (Desktop) et Android (Mobile).

---

## 2. ARCHITECTURE LOGICIELLE (Evolutivité)
L'application suit les principes de la **Clean Architecture** organisée par **Features**. Cela permet de modifier la base de données ou l'UI sans impacter la logique métier.

### Structure du Projet (Flutter Feature-First) :
* `core/` : Services transversaux (Thème, FormatterService, i18n, Utilitaires).
* `domain/` : Entités (Client, Prestation) et Interfaces des dépôts (Logique pure).
* `data/` : Implémentation SQLite (Drift), sources de données locales, DTOs.
* `presentation/` : UI Widgets, State Management (Provider/Bloc), Tailwind v4 Tokens.

---

## 3. STACK TECHNIQUE
| Composant | Technologie |
| :--- | :--- |
| **Framework UI** | Flutter (Dart) |
| **Base de données** | SQLite via **Drift** (Réactivité via Streams) |
| **Design System** | Tailwind CSS v4 (via Tokens personnalisés) |
| **Style Visuel** | Glass Morphism (Effets de verre, flous, transparences) |
| **Localisation** | Package `intl` + `flutter_localizations` |

---

## 4. SPÉCIFICATIONS FONCTIONNELLES

### 4.1 Dashboard & Tracker (Bouton Fusionné)
* **Bouton Unique :** Un seul composant gère l'état `Start` (Bleu/Play) et `Stop` (Rouge/Stop).
* **Saisie Rapide :** Champ texte pour le nom de la tâche accessible en un clic.
* **Persistance :** Le chronomètre survit à la fermeture de l'application (Background Tasks).

### 4.2 Agenda Intelligent
* **Vues :** Jour, Semaine, Mois.
* **Gestion des Collisions :** Algorithme de répartition horizontale automatique. Si deux tâches se chevauchent, elles se partagent la largeur du calendrier.
* **Visuel :** Couleurs dynamiques basées sur l'identité visuelle du client.

### 4.3 Modal de Finalisation (Logiciel d'automatisation)
Lors de l'arrêt d'un chrono ou d'un ajout manuel, un modal s'ouvre avec :
* **Calcul de durée :** Affichage dynamique de la durée totale (HH:MM).
* **Switchs d'automatisation :**
    * *Auto-Start :* Déclenchement à l'heure `H` prévue.
    * *Auto-Stop :* Arrêt automatique à l'heure `H` prévue.
    * *Alerte :* Notification après un temps de dépassement défini (ex: +30 min).

### 4.4 CRM Client (Fiche Détaillée)
* **Champs :** Société, Nom contact, Adresse, Email, Téléphone, Notes.
* **Tarification :** Définition d'un **Tarif Horaire HT** par client.
* **Statistiques dédiées :** Tableau filtrable des prestations, nombre d'heures totales et CA prévisionnel calculé.

---

## 5. DESIGN SYSTEM (Tailwind v4 & Glass)

### Tokens UI :
* **Primary :** `#0A1F44` (Bleu nuit)
* **Accent :** `#007BFF` (Bleu action)
* **Danger :** `#DC3545` (Rouge stop)
* **Glass Effect :** `backdrop-blur: 20px`, bordures blanches translucides (`opacity: 0.2`).

### Thèmes :
* **macOS :** Thème clair par défaut, interface avec Sidebar.
* **Android :** Thème sombre par défaut, interface avec Bottom Navigation.

---

## 6. INTERNATIONALISATION (i18n) & LOCALISATION
L'application propose un découplage complet entre la langue et les formats :

* **Langue :** Multi-langue (FR, EN par défaut).
* **Réglages Manuels (Settings) :**
    * *Date :* `JJ/MM/AAAA` vs `MM/JJ/AAAA`.
    * *Heure :* `24h` vs `12h (AM/PM)`.
    * *Monnaie :* Position du symbole (€/$), séparateur décimal (point/virgule).

---

## 7. SCHÉMA DE LA BASE DE DONNÉES (SQLite)

### Table : `clients`
* `id` (INT, PK)
* `societe`, `nom_contact`, `adresse`, `email`, `telephone`, `notes` (TEXT)
* `tarif_ht` (REAL)
* `color_token` (TEXT)

### Table : `prestations`
* `id` (INT, PK)
* `client_id` (INT, FK)
* `nom_tache` (TEXT)
* `date_debut`, `date_fin` (TEXT - ISO8601)
* `auto_start`, `auto_stop` (BOOLEAN)
* `alerte_minutes` (INT)

### Table : `settings`
* `key` (TEXT, PK)
* `value` (TEXT)

---

## 8. RÈGLES DE DÉVELOPPEMENT & MAINTENANCE
1.  **Inversion de dépendance :** Toujours passer par des interfaces pour les services (Repository Pattern).
2.  **FormatterService :** Centralisation obligatoire de tous les affichages de dates, heures et monnaies.
3.  **Local-First :** Priorité absolue à la base de données locale. L'ajout d'une synchro Cloud doit se faire via une couche de service supplémentaire (SyncService).
4.  **Tests :** Tests unitaires sur les calculs de durée et l'algorithme de collision de l'agenda.

---

## 9. ROADMAP (Évolutions futures)
* **V2.0 :** Export PDF des rapports d'heures par client.
* **V2.1 :** Synchronisation sécurisée via Supabase ou Firebase.
* **V2.2 :** Reconnaissance vocale pour le démarrage rapide d'une tâche.

---

Ce document constitue la base structurelle de **TEMPS-TRACK**. Il est conçu pour être évolutif : chaque composant peut être remplacé ou amélioré sans fragiliser l'édifice global.

