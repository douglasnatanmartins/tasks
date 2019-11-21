import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';

enum CategoriesState {
  Loading,
  Loaded,
}

class CategoriesBloc implements BLoCContract {
  CategoriesBloc() {
    this._fetchCategories();
  }

  final CategoryRepository _repository = CategoryRepository();
  final _controller = StreamController<CategoriesState>.broadcast();
  Stream<CategoriesState> get state => this._controller.stream;

  List<CategoryModel> _categories = <CategoryModel>[];
  List<CategoryModel> get categories => this._categories;

  /// Add new category into database.
  /// 
  /// The [model] argument must not be null.
  Future<bool> addCategory(CategoryModel model) async {
    this._controller.add(CategoriesState.Loading);
    final bool result = await this._repository.add(model.toMap());
    if (result) {
      await this._fetchCategories();
    }
    this._controller.add(CategoriesState.Loaded);
    return result;
  }

  /// Update the category.
  /// 
  /// The [oldModel] and [newModel] arguments must not be null.
  Future<bool> updateCategory(CategoryModel oldModel, CategoryModel newModel) async {
    this._controller.add(CategoriesState.Loading);
    final bool result = await this._repository.update(newModel.toMap());
    if (result) {
      int index = this._categories.indexOf(oldModel);
      this._categories[index] = newModel;
    }
    this._controller.add(CategoriesState.Loaded);
    return result;
  }

  /// Delete the category.
  /// 
  /// The [model] argument must not be null.
  Future<bool> deleteCategory(CategoryModel model) async {
    this._controller.add(CategoriesState.Loading);
    final bool result = await this._repository.delete(model.id);
    if (result) {
      this._categories.remove(model);
    }
    this._controller.add(CategoriesState.Loaded);
    return result;
  }

  /// Fetch all category in database.
  Future<void> _fetchCategories() async {
    this._controller.add(CategoriesState.Loading);
    final data = await this._repository.all();
    this._categories = data.map((Map<String, dynamic> item) {
      return CategoryModel.from(item);
    }).toList();
    this._controller.add(CategoriesState.Loaded);
  }

  /// Dispose the business logic component.
  @override
  void dispose() {
    _controller.close();
  }
}
