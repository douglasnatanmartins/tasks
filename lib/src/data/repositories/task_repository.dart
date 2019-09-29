import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/database_creator.dart';

class TaskRepository {
  TaskRepository();

  /// Get all tasks.
  Future<List<Map<String, dynamic>>> all() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Task");
    return result;
  }

  /// Get all tasks with due date.
  Future<List<Map<String, dynamic>>> allTaskWithDueDate() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT *
      FROM Task
      WHERE due_date IS NOT NULL
      ORDER BY due_date ASC
    ''');
    return result;
  }

  /// Get all important tasks.
  Future<List<Map<String, dynamic>>> allImportantTasks() async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM Task WHERE important = 1');
    return result;
  }

  /// Get all tasks with project id.
  Future<List<Map<String, dynamic>>> getTasksByProjectId(int projectId) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Task WHERE project_id = ?", [projectId]);
    return result;
  }

  /// Get task with id.
  Future<Map<String, dynamic>> getTaskById(int id) async {
    Database db = await DatabaseCreator().database;
    List<Map<String, dynamic>> result = await db.rawQuery("SELECT * FROM Task WHERE id = ?", [id]);
    if (result.length > 0) {
      return result[0];
    }

    return null;
  }

  /// Add new task.
  Future<bool> add(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.insert('Task', object);
    return result != 0 ? true : false;
  }

  /// Delete task by id.
  Future<bool> delete(int id) async {
    Database db = await DatabaseCreator().database;
    int result = await db.delete('Task', where: 'id = ?', whereArgs: [id]);
    return result != 0 ? true : false;
  }

  /// Update task with id.
  Future<bool> update(Map<String, dynamic> object) async {
    Database db = await DatabaseCreator().database;
    int result = await db.update('Task', object, where: 'id = ?', whereArgs: [object['id']]);
    return result != 0 ? true : false;
  }
}
