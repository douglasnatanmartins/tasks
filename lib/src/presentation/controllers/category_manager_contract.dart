import 'package:tasks/src/domain/entities/category_entity.dart';

abstract class CategoryManagerContract {
  /// Create new category.
  /// 
  /// The [data] argument must not be null.
  Future<bool> createCategory(CategoryEntity data);

  /// Delete the category.
  /// 
  /// The [data] argument must not be null.
  Future<bool> deleteCategory(CategoryEntity data);

  /// Update the category.
  /// 
  /// The [current] and [previous] arguments must not be null.
  Future<bool> updateCategory(CategoryEntity current, CategoryEntity previous);
}
