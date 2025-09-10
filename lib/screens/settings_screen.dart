// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _budgetController = TextEditingController();
  Color _selectedColor = Colors.teal;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    _budgetController.text = provider.monthlyBudget.toStringAsFixed(2);
    _selectedColor = provider.cardColor ?? Colors.teal;
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TransactionProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Budget', style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.bold)),
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Budget Amount',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onSubmitted: (value) {
                final budget = double.tryParse(value) ?? provider.monthlyBudget;
                provider.setMonthlyBudget(budget);
              },
            ),
            SizedBox(height: size.height * 0.03),
            Text('Theme Color', style: TextStyle(fontSize: size.width * 0.045, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: [
                Colors.teal,
                Colors.blue,
                Colors.purple,
                Colors.orange,
                Colors.green,
              ].map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedColor = color);
                    provider.setCardColor(color);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedColor == color ? Colors.black : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}