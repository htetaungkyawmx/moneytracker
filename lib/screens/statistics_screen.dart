// lib/screens/statistics_screen.dart
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            Text(
              'Expenses by Category',
              style: TextStyle(fontSize: size.width * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Expanded(
              child: PieChartWidget(data: expensesByCategory),
            ),
          ],
        ),
      ),
    );
  }
}