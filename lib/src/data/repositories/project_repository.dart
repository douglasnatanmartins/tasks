import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/database_creator.dart';
import 'package:tasks/src/data/repositories/task_repository.dart';

class ProjectRepository {
  TaskRepository _taskRepository;

  ProjectRepository() {
    _taskRepository = TaskRepository();
  }

  /// Get all projects.
  Future<List<Map<String, dynamic>>> all() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Project");
    return result;
  }

  /// Get all project with category id.
  Future<List<Map<String, dynamic>>> getProjectsByCategoryId(int categoryId) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Project WHERE categoryId = ?", [categoryId]);
    return result;
  }

  /// Get project with id.
  Future<Map<String, dynamic>> getProjectById(int id) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Project WHERE id = ?", [id]);
    if (result.length > 0) {
      return result[0];
    }
    return null;
  }

  /// Add new project.
  Future<bool> add(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.insert('Project', object);
    return result != 0 ? true : false;
  }

  /// Delete project with project id.
  Future<bool> delete(int id) async {
    Database db = await DatabaseCreator().database;
    _taskRepository.getTasksByProjectId(id).then((tasks) {
      tasks.forEach((task) {
        _taskRepository.delete(task['id']);
      });
    });
    int result = await db.delete('Project', where: 'id = ?', whereArgs: [id]);
    return result != 0 ? true : false;
  }

  /// Delete all project with category id.
  Future<bool> deleteProjectsByCategoryId(int categoryId) async {
    Database db = await DatabaseCreator().database;
    int result = await db.delete('Project', where: 'id = ?', whereArgs: [categoryId]);
    return result != 0 ? true : false;
  }

  /// Update project with id.
  Future<bool> update(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.update('Project', object, where: 'id = ?', whereArgs: [object['id']]);
    return result != 0 ? true : false;
  }
}
