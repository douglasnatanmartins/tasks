import '../entities/category_entity.dart';

abstract class CategoryRepositoryContract {
  Future<List<CategoryEntity>> getAll();
  Future<CategoryEntity> getCategoryById(int id);
  Future<bool> createCategory(CategoryEntity data);
  Future<bool> updateCategory(CategoryEntity data);
  Future<bool> deleteCategory(CategoryEntity data);
}
