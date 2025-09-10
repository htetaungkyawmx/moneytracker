import 'package:flutter/material.dart';
import 'package:money_tracker_app/data/models/category.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/category_provider.dart';
import '../data/models/transaction.dart';
import '../utils/helpers.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionProvider>(context).transactions;
    final categories = Provider.of<CategoryProvider>(context).categories;
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final cat = categories.firstWhere(
              (c) => c.name == tx.category,
          orElse: () => Category(name: 'Unknown', icon: Icons.help, color: Colors.grey),
        );
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: cat.color,
              child: Icon(cat.icon, color: Colors.white),
            ),
            title: Text(tx.description),
            subtitle: Text(formatDate(tx.date)),
            trailing: Text(
              '${tx.isExpense ? '-' : '+'}\$${tx.amount.toStringAsFixed(2)}',
              style: TextStyle(color: tx.isExpense ? Colors.red : Colors.green),
            ),
            onLongPress: () {
              // Edit or delete options
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Transaction?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Provider.of<TransactionProvider>(context, listen: false)
                            .deleteTransaction(tx.id!);
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('No'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}