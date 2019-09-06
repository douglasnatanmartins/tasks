import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/database_creator.dart';
import 'package:tasks/src/data/models/category_model.dart';

class CategoryRepository {
  Future<List<CategoryModel>> all() async {
    Database db = await DatabaseCreator().database;
    List<CategoryModel> categories = [];
    List<Map<String, dynamic>> records = await db.rawQuery("SELECT * FROM Category");
    records.forEach((record) {
      categories.add(CategoryModel.from(record));
    });
    return categories;
  }

  Future<CategoryModel> getById(int id) async {
    Database db = await DatabaseCreator().database;
    dynamic result = await db.rawQuery("SELECT * FROM Category WHERE id = ?", [id]);
    return CategoryModel.from(result);
  }

  Future<CategoryModel> add(CategoryModel category) async {
    Database db = await DatabaseCreator().database;
    await db.insert('Category', category.toMap());
    return category;
  }

  Future<int> delete(CategoryModel category) async {
    Database db = await DatabaseCreator().database;
    int id = await db.delete('Category', where: 'id = ?', whereArgs: [category.id]);
    return id;
  }

  Future<CategoryModel> update(CategoryModel category) async {
    return category;
  }
}
