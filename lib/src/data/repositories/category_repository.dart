import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/database_creator.dart';
import 'package:tasks/src/data/repositories/project_repository.dart';

class CategoryRepository {
  ProjectRepository _projectRepository;

  CategoryRepository() {
    _projectRepository = ProjectRepository();
  }

  /// Get all categories.
  Future<List<Map<String, dynamic>>> all() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Category");
    return result;
  }

  /// Get category with id.
  Future<Map<String, dynamic>> getCategoryById(int id) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Category WHERE id = ?", [id]);
    if (result.length > 0) {
      return result[0];
    }

    return null;
  }

  /// Add new category.
  Future<bool> add(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.insert('Category', object);
    return result != 0 ? true : false;
  }

  /// Delete category with id.
  Future<bool> delete(int id) async {
    Database db = await DatabaseCreator().database;
    _projectRepository.getProjectsByCategoryId(id).then((projects) {
      projects.forEach((project) {
        _projectRepository.delete(project['id']);
      });
    });
    int result = await db.delete('Category', where: 'id = ?', whereArgs: [id]);
    return result != 0 ? true : false;
  }

  /// Update category with id.
  Future<bool> update(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.update('Category', object, where: 'id = ?', whereArgs: [object['id']]);
    return result != 0 ? true : false;
  }
}
