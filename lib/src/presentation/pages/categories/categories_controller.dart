import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/repositories/category_repository_contract.dart';
import 'package:tasks/src/domain/usecases/get_category_repository.dart';
import 'package:tasks/src/presentation/controllers/category_manager_contract.dart';

class CategoriesController extends Controller with CategoryManagerContract {
  CategoriesController() {
    this._categoryRepository = GetCategoryRepository().getRepository();
    this._categoriesController = StreamController<List<CategoryEntity>>.broadcast();

    // Initial
    this._fetchCategories().then((result) {
      this.pushCategories();
    });
  }

  CategoryRepositoryContract _categoryRepository;
  StreamController<List<CategoryEntity>> _categoriesController;
  Stream<List<CategoryEntity>> get categories => this._categoriesController.stream;

  List<CategoryEntity> _categories;

  @override
  Future<bool> addCategory(CategoryEntity entity) async {
    final result = await this._categoryRepository.createCategory(entity);
    if (result) {
      await this._fetchCategories();
      this.pushCategories();
    }
    return result;
  }

  @override
  Future<bool> updateCategory(CategoryEntity previous, CategoryEntity current) async {
    final result = await this._categoryRepository.updateCategory(current);
    if (result) {
      final index = this._categories.indexOf(previous);
      this._categories[index] = current;
      this.pushCategories();
    }
    return result;
  }

  @override
  Future<bool> deleteCategory(CategoryEntity entity) async {
    final result = await this._categoryRepository.deleteCategory(entity);
    if (result) {
      this._categories.remove(entity);
      this.pushCategories();
    }
    return result;
  }

  Future<void> pushCategories() async {
    this._categoriesController.add(this._categories);
  }

  Future<void> _fetchCategories() async {
    this._categories = await this._categoryRepository.getAll();
  }

  @override
  void dispose() {
    _categoriesController.close();
  }
}
