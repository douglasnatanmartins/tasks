import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/repositories/category_repository_contract.dart';
import '../datasources/local_source.dart';

class CategoryRepository extends CategoryRepositoryContract {
  @override
  Future<List<CategoryEntity>> getAll() async {
    Database db = await LocalSource().database;
    var data = await db.query('Category');
    List<CategoryEntity> result = <CategoryEntity>[];
    if (data.isNotEmpty) {
      for (var category in data) {
        result.add(CategoryModel.from(category));
      }
    }

    return result;
  }

  @override
  Future<CategoryEntity> getCategoryById(int id) async {
    var db = await LocalSource().database;
    var data = await db.query(
      'Category',
      where: 'id = ?',
      whereArgs: [id]
    );

    if (data.length > 0) {
      return CategoryModel.from(data.elementAt(0));
    }

    return null;
  }

  @override
  Future<bool> createCategory(CategoryEntity data) async {
    var db = await LocalSource().database;
    int result = await db.insert('Category', mapping(data));

    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteCategory(CategoryEntity data) async {
    var db = await LocalSource().database;
    int result = await db.delete(
      'Category',
      where: 'id = ?',
      whereArgs: [data.id],
    );

    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateCategory(CategoryEntity data) async {
    var db = await LocalSource().database;
    int result = await db.update(
      'Category',
      mapping(data),
      where: 'id = ?',
      whereArgs: [data.id],
    );

    return result != 0 ? true : false;
  }

  Map<String, dynamic> mapping(CategoryEntity data) {
    return <String, dynamic>{
      'id': data.id,
      'title': data.title,
      'description': data.description,
      'created_date': data.createdDate.toString(),
    };
  }
}
