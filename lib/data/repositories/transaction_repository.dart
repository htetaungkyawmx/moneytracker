import '../local_database/database_helper.dart';
import '../models/transaction.dart';

class TransactionRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Transaction>> getAllTransactions() async {
    final data = await _dbHelper.getTransactions();
    return data.map((map) => Transaction.fromMap(map)).toList();
  }

  Future<void> insertTransaction(Transaction transaction) async {
    await _dbHelper.insertTransaction(transaction);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _dbHelper.updateTransaction(transaction);
  }

  Future<void> deleteTransaction(int id) async {
    await _dbHelper.deleteTransaction(id);
  }
}