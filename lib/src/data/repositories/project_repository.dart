import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/database_creator.dart';

import 'package:tasks/src/data/models/project_model.dart';

class ProjectRepository {
  Future<List<ProjectModel>> all() async {
    Database db = await DatabaseCreator().database;
    List<ProjectModel> objects = [];
    List<Map<String, dynamic>> records = await db.rawQuery("SELECT * FROM Project");
    records.forEach((record) {
      objects.add(ProjectModel.from(record));
    });
    return objects;
  }

  Future<List<ProjectModel>> getByCategoryId(int id) async {
    Database db = await DatabaseCreator().database;
    List<ProjectModel> objects = [];
    List<Map<String, dynamic>> records = await db.rawQuery("SELECT * FROM Project WHERE categoryId = ?", [id]);
    records.forEach((record) {
      objects.add(ProjectModel.from(record));
    });
    return objects;
  }

  Future<ProjectModel> getById(int id) async {
    Database db = await DatabaseCreator().database;
    dynamic result = await db.rawQuery("SELECT * FROM Project WHERE id = ?", [id]);
    return ProjectModel.from(result);
  }

  Future<ProjectModel> add(ProjectModel object) async {
    Database db = await DatabaseCreator().database;
    await db.insert('Project', object.toMap());
    return object;
  }

  Future<int> delete(ProjectModel object) async {
    Database db = await DatabaseCreator().database;
    int id = await db.delete('Project', where: 'id = ?', whereArgs: [object.id]);
    return id;
  }

  Future<ProjectModel> update(ProjectModel object) async {
    return object;
  }
}
