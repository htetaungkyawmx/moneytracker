// lib/screens/add_transaction_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/category_provider.dart';
import '../data/models/transaction.dart';
import '../utils/helpers.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  double _amount = 0.0;
  String _category = '';
  String _description = '';
  DateTime _date = DateTime.now();
  bool _isExpense = true;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final size = MediaQuery.of(context).size; // Responsive
    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: SingleChildScrollView( // For better UX on small screens
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter amount' : null,
                  onSaved: (value) => _amount = double.parse(value!),
                ),
                SizedBox(height: size.height * 0.02),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  items: categoryProvider.categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat.name,
                      child: Row(
                        children: [
                          Icon(cat.icon, color: cat.color),
                          const SizedBox(width: 10),
                          Text(cat.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _category = value!),
                  validator: (value) => value == null ? 'Select category' : null,
                ),
                SizedBox(height: size.height * 0.02),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onSaved: (value) => _description = value!,
                ),
                SizedBox(height: size.height * 0.02),
                ListTile(
                  title: const Text('Date'),
                  subtitle: Text(formatDate(_date)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (selectedDate != null) setState(() => _date = selectedDate);
                  },
                ),
                SwitchListTile(
                  title: const Text('Is Expense?'),
                  value: _isExpense,
                  onChanged: (value) => setState(() => _isExpense = value),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: size.height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final transaction = Transaction(
                        amount: _amount,
                        category: _category,
                        description: _description,
                        date: _date,
                        isExpense: _isExpense,
                      );
                      Provider.of<TransactionProvider>(context, listen: false)
                          .addTransaction(transaction);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}