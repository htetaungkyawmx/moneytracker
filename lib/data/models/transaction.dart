// lib/data/models/transaction.dart
class Transaction {
  final int? id;
  final double amount;
  final String category;
  final String description;
  final DateTime date;
  final bool isExpense;

  Transaction({
    this.id,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
    required this.isExpense,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date.toIso8601String(),
      'isExpense': isExpense ? 1 : 0,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      isExpense: map['isExpense'] == 1,
    );
  }
}