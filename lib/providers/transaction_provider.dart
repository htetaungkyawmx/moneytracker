import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/transaction.dart';
import '../data/repositories/transaction_repository.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  double _monthlyBudget = 1000.0;
  bool _isDarkMode = false;
  Color? _cardColor;
  final TransactionRepository _repo = TransactionRepository();

  List<Transaction> get transactions => _transactions;
  double get monthlyBudget => _monthlyBudget;
  double get totalIncome => _transactions
      .where((t) => !t.isExpense)
      .fold(0.0, (sum, t) => sum + t.amount);
  double get totalExpenses => _transactions
      .where((t) => t.isExpense)
      .fold(0.0, (sum, t) => sum + t.amount);
  double get balance => totalIncome - totalExpenses;
  double get budgetRemaining => _monthlyBudget - totalExpenses;
  bool get isDarkMode => _isDarkMode;
  Color? get cardColor => _cardColor;

  TransactionProvider() {
    _loadTransactions();
    _loadPreferences();
  }

  Future<void> _loadTransactions() async {
    _transactions = await _repo.getAllTransactions();
    notifyListeners();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    final colorValue = prefs.getInt('cardColor');
    if (colorValue != null) {
      _cardColor = Color(colorValue);
    }
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await _repo.insertTransaction(transaction);
    _transactions.add(transaction);
    notifyListeners();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _repo.updateTransaction(transaction);
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(int id) async {
    await _repo.deleteTransaction(id);
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void setMonthlyBudget(double budget) {
    _monthlyBudget = budget;
    notifyListeners();
  }

  void toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void setCardColor(Color color) async {
    _cardColor = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cardColor', color.value);
    notifyListeners();
  }
}