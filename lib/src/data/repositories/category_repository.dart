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
    List<Map<String, dynamic>> data = await db.query('Category');
    List<CategoryEntity> result = <CategoryEntity>[];
    if (data.isNotEmpty) {
      result = data.map<CategoryEntity>((Map<String, dynamic> item) {
        return CategoryModel.from(item);
      }).toList();
    }

    return result;
  }

  @override
  Future<CategoryEntity> getCategoryById(int id) async {
    Database db = await LocalSource().database;

    final data = await db.query(
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
  Future<bool> createCategory(CategoryEntity entity) async {
    Database db = await LocalSource().database;

    int result = await db.insert('Category', mapping(entity));

    return result != 0 ? true : false;
  }

  @override
  Future<bool> deleteCategory(CategoryEntity entity) async {
    Database db = await LocalSource().database;

    int result = await db.delete(
      'Category',
      where: 'id = ?',
      whereArgs: [entity.id]
    );

    return result != 0 ? true : false;
  }

  @override
  Future<bool> updateCategory(CategoryEntity entity) async {
    Database db = await LocalSource().database;

    int result = await db.update(
      'Category',
      mapping(entity),
      where: 'id = ?',
      whereArgs: [entity.id]
    );

    return result != 0 ? true : false;
  }

  Map<String, dynamic> mapping(CategoryEntity entity) {
    return <String, dynamic>{
      'id': entity.id,
      'title': entity.title,
      'description': entity.description,
      'created_date': entity.createdDate.toString(),
    };
  }
}
