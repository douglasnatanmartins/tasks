import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';

/// Category Page Business Logic Component.
class CategoriesPageBloc implements BlocContract {
  final _controllerCategories = StreamController<List<CategoryModel>>.broadcast();
  Sink get sinkCategories => _controllerCategories.sink;
  Stream get streamCategories => _controllerCategories.stream;

  CategoryRepository categoryRepository;

  CategoriesPageBloc() {
    this.categoryRepository = CategoryRepository();
  }

  /// Add a category into database.
  Future<bool> addCategory(CategoryModel category) async {
    bool result = await this.categoryRepository.add(category.toMap());
    if (result) {
      await this.refreshCategories();
    }
    return result;
  }

  /// Refresh category list.
  Future<void> refreshCategories() async {
    final data = await this.categoryRepository.all();
    List<CategoryModel> categories = [];
    data.forEach((Map<String, dynamic> task) {
      categories.add(CategoryModel.from(task));
    });
    this.sinkCategories.add(categories);
  }

  /// Dispose this business logic component.
  @override
  void dispose() {
    this.categoryRepository = null;
    _controllerCategories.close();
  }
}
