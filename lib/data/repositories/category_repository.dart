// lib/data/repositories/category_repository.dart
import '../local_database/database_helper.dart';
import '../models/category.dart';

class CategoryRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<List<Category>> getAllCategories() async {
    final data = await _dbHelper.getCategories();
    return data.map((map) => Category.fromMap(map)).toList();
  }

  Future<void> insertCategory(Category category) async {
    await _dbHelper.insertCategory(category);
  }

  Future<void> updateCategory(Category category) async {
    await _dbHelper.updateCategory(category);
  }

  Future<void> deleteCategory(int id) async {
    await _dbHelper.deleteCategory(id);
  }
}