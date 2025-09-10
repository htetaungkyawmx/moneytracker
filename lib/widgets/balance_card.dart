// lib/widgets/balance_card.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(size.width * 0.04),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary.withOpacity(0.7), theme.colorScheme.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Balance',
              style: TextStyle(color: Colors.white, fontSize: size.width * 0.045),
            ),
            Text(
              '\$${provider.balance.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Income', style: TextStyle(color: Colors.white70)),
                    Text(
                      '\$${provider.totalIncome.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Expenses', style: TextStyle(color: Colors.white70)),
                    Text(
                      '\$${provider.totalExpenses.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: size.height * 0.01),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Monthly Budget Remaining', style: TextStyle(color: Colors.white70)),
                Text(
                  '\$${provider.budgetRemaining.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.white, fontSize: size.width * 0.04),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}