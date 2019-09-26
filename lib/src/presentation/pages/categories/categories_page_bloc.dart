import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';

/// Category Page Business Logic Component.
class CategoriesPageBloc implements BlocContract {
  final _controllerCategories = StreamController<List<CategoryModel>>.broadcast();
  Sink get sinkCategories => _controllerCategories.sink;
  Stream get streamCategories => _controllerCategories.stream;

  CategoryRepository _repository;

  CategoriesPageBloc() {
    this._repository = CategoryRepository();
  }

  /// Add a category into database.
  void addCategory(CategoryModel category) {
    this._repository.add(category.toMap());
    refreshCategories();
  }

  /// Refresh category list.
  void refreshCategories() {
    this._repository.all().then((categories) {
      List<CategoryModel> data = [];

      categories.forEach((category) {
        data.add(CategoryModel.from(category));
      });

      this.sinkCategories.add(data);
    });
  }

  @override
  void dispose() {
    this._controllerCategories.close();
  }
}
