// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../data/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  IconData _icon = Icons.category;
  Color _color = Colors.grey;

  final List<IconData> _icons = [
    Icons.fastfood, Icons.directions_car, Icons.movie, Icons.attach_money,
    Icons.home, Icons.shopping_cart, Icons.flight, Icons.school,
  ];

  final List<Color> _colors = [
    Colors.red, Colors.blue, Colors.purple, Colors.green,
    Colors.orange, Colors.teal, Colors.pink, Colors.indigo,
  ];

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Name'),
                        onSaved: (value) => _name = value!,
                        validator: (value) => value!.isEmpty ? 'Enter name' : null,
                      ),
                      const SizedBox(height: 10),
                      const Text('Select Icon'),
                      Wrap(
                        spacing: 10,
                        children: _icons.map((icon) {
                          return GestureDetector(
                            onTap: () => setDialogState(() => _icon = icon),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _icon == icon ? Theme.of(context).colorScheme.primary.withOpacity(0.3) : null,
                              ),
                              child: Icon(icon),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      const Text('Select Color'),
                      Wrap(
                        spacing: 10,
                        children: _colors.map((color) {
                          return GestureDetector(
                            onTap: () => setDialogState(() => _color = color),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _color == color ? Colors.black : Colors.transparent,
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
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final category = Category(name: _name, icon: _icon, color: _color);
                  Provider.of<CategoryProvider>(context, listen: false).addCategory(category);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.builder(
        itemCount: provider.categories.length,
        itemBuilder: (context, index) {
          final cat = provider.categories[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.01),
            child: ListTile(
              leading: Icon(cat.icon, color: cat.color),
              title: Text(cat.name),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => provider.deleteCategory(cat.id!),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}