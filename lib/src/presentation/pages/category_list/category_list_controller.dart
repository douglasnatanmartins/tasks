import 'dart:async';

import 'package:tasks/src/core/contracts/controller.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/usecases/get_category_repository.dart';
import 'package:tasks/src/presentation/controllers/category_manager_contract.dart';

/// The Business Logic Component for the Category List Page.
class CategoryListController implements Controller, CategoryManagerContract {
  /// Constructor of Business Logic Component for the Category List Page.
  CategoryListController() {
    _fetchCategories().then((result) {
      pushCategories();
    });
  }

  final _categoryRepository = GetCategoryRepository().getRepository();
  final _categoryListController = StreamController<List<CategoryEntity>>.broadcast();
  Stream<List<CategoryEntity>> get categories => _categoryListController.stream;

  List<CategoryEntity> _categories = <CategoryEntity>[];

  @override
  Future<bool> createCategory(CategoryEntity data) async {
    var result = await _categoryRepository.createCategory(data);
    if (result) {
      await _fetchCategories();
      pushCategories();
    }

    return result;
  }

  @override
  Future<bool> deleteCategory(CategoryEntity data) async {
    var result = await _categoryRepository.deleteCategory(data);
    if (result) {
      _categories.remove(data);
      pushCategories();
    }

    return result;
  }

  @override
  Future<bool> updateCategory(CategoryEntity current, CategoryEntity previous) async {
    var result = await _categoryRepository.updateCategory(current);
    if (result) {
      int index = _categories.indexOf(previous);
      _categories[index] = current;
      pushCategories();
    }

    return result;
  }

  Future<void> pushCategories() async {
    _categoryListController.add(_categories);
  }

  Future<void> _fetchCategories() async {
    _categories = await _categoryRepository.getAll();
  }

  @override
  void dispose() {
    _categoryListController.close();
  }
}
