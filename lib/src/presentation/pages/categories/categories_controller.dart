import 'dart:async';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';
import 'package:tasks/src/presentation/controllers/categories_controller_interface.dart';

class CategoriesController implements CategoriesControllerInterface {
  CategoriesController() {
    this._fetchCategories().then((result) {
      this.pushCategories();
    });
  }

  final _categoryRepository = CategoryRepository();
  final _categoriesController = StreamController<List<CategoryModel>>.broadcast();
  Stream<List<CategoryModel>> get categories => _categoriesController.stream;
  List<CategoryModel> _categories = <CategoryModel>[];

  @override
  Future<bool> addCategory(CategoryModel model) async {
    final result = await this._categoryRepository.add(model.toMap());
    if (result) {
      await this._fetchCategories();
      this.pushCategories();
    }
    return result;
  }

  @override
  Future<bool> updateCategory(CategoryModel previous, CategoryModel current) async {
    final result = await this._categoryRepository.update(current.toMap());
    if (result) {
      final index = this._categories.indexOf(previous);
      this._categories[index] = current;
      this.pushCategories();
    }
    return result;
  }

  @override
  Future<bool> deleteCategory(CategoryModel model) async {
    final result = await this._categoryRepository.delete(model.id);
    if (result) {
      this._categories.remove(model);
      this.pushCategories();
    }
    return result;
  }

  Future<void> pushCategories() async {
    this._categoriesController.add(this._categories);
  }

  Future<void> _fetchCategories() async {
    final data = await this._categoryRepository.all();
    if (data.isNotEmpty) {
      this._categories = data.map((Map<String, dynamic> item) {
        return CategoryModel.from(item);
      }).toList();
    }
  }

  @override
  void dispose() {
    _categoriesController.close();
  }
}
