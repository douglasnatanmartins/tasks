import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/datasources/local_source.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/repositories/project_repository_contract.dart';
import 'package:tasks/src/utils/data_support.dart';

class ProjectRepository implements ProjectRepositoryContract {
  @override
  Future<List<ProjectEntity>> getAll() async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query('Project');
    if (data.isNotEmpty) {
      List<ProjectEntity> result = <ProjectEntity>[];
      result = data.map((Map<String, dynamic> item) {
        return ProjectModel.from(item);
      }).toList();
      return result;
    }

    return null;
  }

  @override
  Future<List<ProjectEntity>> getAllProjectByCategoryId(int categoryId) async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query(
      'Project',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );

    if (data.isNotEmpty) {
      List<ProjectEntity> result = data.map((Map<String, dynamic> item) {
        return ProjectModel.from(item);
      }).toList();
      return result;
    }

    return null;
  }

  @override
  Future<ProjectEntity> getProjectById(int id) async {
    Database db = await LocalSource().database;
    List<Map<String, dynamic>> data = await db.query('Project', where: 'id = ?', whereArgs: [id]);

    if (data.length > 0) {
      return ProjectModel.from(data.elementAt(0));
    }

    return null;
  }

  @override
  Future<bool> createProject(ProjectEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.insert('Project', mapping(entity));
    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteProject(ProjectEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.delete('Project', where: 'id = ?', whereArgs: [entity.id]);
    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateProject(ProjectEntity entity) async {
    Database db = await LocalSource().database;
    int result = await db.update('Project', mapping(entity), where: 'id = ?', whereArgs: [entity.id]);
    return result != 0 ? true : false;
  }

  Map<String, dynamic> mapping(ProjectEntity entity) {
    return <String, dynamic>{
      'id': entity.id,
      'category_id': entity.categoryId,
      'title': entity.title,
      'description': entity.description,
      'color': entity.color.value.toString(),
      'icon': DataSupport.getIconKey(entity.icon),
      'created_date': entity.createdDate.toString(),
    };
  }
}
