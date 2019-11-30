import '../entities/category_entity.dart';

abstract class CategoryRepositoryContract {
  Future<List<CategoryEntity>> getAll();
  Future<CategoryEntity> getCategoryById(int id);
  Future<bool> createCategory(CategoryEntity object);
  Future<bool> updateCategory(CategoryEntity object);
  Future<bool> deleteCategory(CategoryEntity object);
}
