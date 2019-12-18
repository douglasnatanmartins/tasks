import 'dart:async';
import 'package:tasks/src/data/datasources/local_source.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/domain/repositories/project_repository_contract.dart';
import 'package:tasks/src/utils/data_support.dart';

class ProjectRepository implements ProjectRepositoryContract {
  @override
  Future<List<ProjectEntity>> getAll() async {
    var db = await LocalSource().database;
    var data = await db.query('Project');
    List<ProjectEntity> result = <ProjectEntity>[];
    if (data.isNotEmpty) {
      for (var project in data) {
        result.add(ProjectModel.from(project));
      }
    }

    return result;
  }

  @override
  Future<List<ProjectEntity>> getAllProjectByCategoryId(int categoryId) async {
    var db = await LocalSource().database;
    var data = await db.query(
      'Project',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );

    List<ProjectEntity> result = <ProjectEntity>[];
    if (data.isNotEmpty) {
      for (var project in data) {
        result.add(ProjectModel.from(project));
      }
    }

    return result;
  }

  @override
  Future<ProjectEntity> getProjectById(int id) async {
    var db = await LocalSource().database;
    var data = await db.query('Project', where: 'id = ?', whereArgs: [id]);

    if (data.length > 0) {
      return ProjectModel.from(data.elementAt(0));
    }

    return null;
  }

  @override
  Future<bool> createProject(ProjectEntity data) async {
    var db = await LocalSource().database;
    int result = await db.insert('Project', mapping(data));
    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteProject(ProjectEntity data) async {
    var db = await LocalSource().database;
    int result = await db.delete(
      'Project',
      where: 'id = ?',
      whereArgs: [data.id],
    );

    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateProject(ProjectEntity data) async {
    var db = await LocalSource().database;
    int result = await db.update(
      'Project',
      mapping(data),
      where: 'id = ?',
      whereArgs: [data.id],
    );

    return result != 0 ? true : false;
  }

  Map<String, dynamic> mapping(ProjectEntity data) {
    return <String, dynamic>{
      'id': data.id,
      'category_id': data.categoryId,
      'title': data.title,
      'description': data.description,
      'color': data.color.value.toString(),
      'icon': DataSupport.getIconKey(data.icon),
      'created_date': data.createdDate.toString(),
    };
  }
}
