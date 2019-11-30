import 'package:tasks/src/domain/entities/category_entity.dart';

abstract class CategoryManagerContract {
  /// Add new category.
  Future<bool> addCategory(CategoryEntity model);

  /// Update the category.
  Future<bool> updateCategory(CategoryEntity previous, CategoryEntity current);

  /// Delete the category.
  Future<bool> deleteCategory(CategoryEntity model);
}
