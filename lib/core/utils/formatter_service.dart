import 'package:intl/intl.dart';

/// Les formats de date supportés par l'app
enum DateFormatType { dmy, mdy, ymd }

class FormatterService {
  // Ces variables seront normalement chargées depuis la DB SQLite (Table Settings)
  // Pour le prototype, nous utilisons des valeurs par défaut.
  static DateFormatType _dateType = DateFormatType.dmy;
  static bool _is24h = true;
  static bool _symbolAtEnd = true;
  static String _currencySymbol = "€";

  /// 1. FORMATAGE DE LA DATE
  /// Transforme un DateTime en String selon le choix de l'utilisateur
  static String formatDate(DateTime date) {
    switch (_dateType) {
      case DateFormatType.mdy:
        return DateFormat('MM/dd/yyyy').format(date);
      case DateFormatType.ymd:
        return DateFormat('yyyy-MM-dd').format(date);
      case DateFormatType.dmy:
      default:
        return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  /// 2. FORMATAGE DE L'HEURE
  /// Gère le passage entre 14:30 (24h) et 02:30 PM (12h)
  static String formatTime(DateTime date) {
    if (_is24h) {
      return DateFormat('HH:mm').format(date);
    } else {
      return DateFormat('hh:mm a').format(date);
    }
  }

  /// 3. FORMATAGE DE LA DURÉE (HH:MM)
  /// Crucial pour le tracker et l'agenda
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    return "$hours:$minutes";
  }

  /// 4. FORMATAGE DE LA MONNAIE
  /// Gère "100,00 €" vs "$100.00"
  static String formatCurrency(double amount) {
    // On utilise un formateur de nombre standard
    final numberFormat = NumberFormat.currency(
      symbol: _currencySymbol,
      decimalDigits: 2,
      customPattern: _symbolAtEnd ? "#,##0.00 ¤" : "¤#,##0.00",
    );
    return numberFormat.format(amount);
  }

  // --- SETTERS POUR LES RÉGLAGES (Appelés par le menu Settings) ---

  static void updateSettings({
    DateFormatType? dateType,
    bool? is24h,
    bool? symbolAtEnd,
    String? currency,
  }) {
    if (dateType != null) _dateType = dateType;
    if (is24h != null) _is24h = is24h;
    if (symbolAtEnd != null) _symbolAtEnd = symbolAtEnd;
    if (currency != null) _currencySymbol = currency;
  }
}