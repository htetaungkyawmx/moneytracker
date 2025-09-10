import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/charts/pie_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final expensesByCategory = <String, double>{};
    for (var tx in provider.transactions.where((t) => t.isExpense)) {
      expensesByCategory[tx.category] = (expensesByCategory[tx.category] ?? 0) + tx.amount;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Expenses by Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PieChartWidget(data: expensesByCategory),
            ),
          ],
        ),
      ),
    );
  }
}