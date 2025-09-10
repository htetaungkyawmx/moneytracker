// lib/providers/category_provider.dart
import 'package:flutter/material.dart';
import '../data/models/category.dart';
import '../data/repositories/category_repository.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  final CategoryRepository _repo = CategoryRepository();

  List<Category> get categories => _categories;

  CategoryProvider() {
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    _categories = await _repo.getAllCategories();
    if (_categories.isEmpty) {
      // Add default categories
      final defaults = [
        Category(name: 'Food', icon: Icons.fastfood, color: Colors.red),
        Category(name: 'Transport', icon: Icons.directions_car, color: Colors.blue),
        Category(name: 'Entertainment', icon: Icons.movie, color: Colors.purple),
        Category(name: 'Salary', icon: Icons.attach_money, color: Colors.green),
      ];
      for (var cat in defaults) {
        await addCategory(cat);
      }
    }
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await _repo.insertCategory(category);
    _categories.add(category);
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    await _repo.updateCategory(category);
    final index = _categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      _categories[index] = category;
      notifyListeners();
    }
  }

  Future<void> deleteCategory(int id) async {
    await _repo.deleteCategory(id);
    _categories.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}