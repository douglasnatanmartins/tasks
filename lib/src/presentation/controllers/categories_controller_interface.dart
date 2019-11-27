import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/data/models/category_model.dart';

abstract class CategoriesControllerInterface implements Controller{
  Future<bool> addCategory(CategoryModel model);
  Future<bool> updateCategory(CategoryModel previous, CategoryModel current);
  Future<bool> deleteCategory(CategoryModel model);
}
