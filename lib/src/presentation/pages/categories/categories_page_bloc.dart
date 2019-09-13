import 'dart:async';

import 'package:tasks/src/core/contracts/bloc_contract.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';

class CategoriesPageBloc implements BlocContract {
  final _controllerCategories = StreamController<List<CategoryModel>>.broadcast();
  Sink get sinkCategories => _controllerCategories.sink;
  Stream get streamCategories => _controllerCategories.stream;

  CategoryRepository _repository;

  CategoriesPageBloc() {
    _repository = CategoryRepository();
    refreshCategories();
  }

  void addCategory(CategoryModel category) {
    _repository.add(category.toMap());
    refreshCategories();
  }

  void refreshCategories() {
    _repository.all().then((categories) {
      List<CategoryModel> data = [];
      categories.forEach((category) {
        data.add(CategoryModel.from(category));
      });
      sinkCategories.add(data);
    });
  }

  @override
  void dispose() {
    _controllerCategories.close();
  }
}
