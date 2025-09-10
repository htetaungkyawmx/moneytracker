// lib/utils/helpers.dart
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatCurrency(double amount) {
  return '\$${amount.toStringAsFixed(2)}';
}