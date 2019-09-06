import 'dart:async';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/repositories/category_repository.dart';

class HomeScreenBloc {
  final _controllerOfHome = StreamController.broadcast();
  Sink get sinkOfHome => _controllerOfHome.sink;
  Stream get streamOfHome => _controllerOfHome.stream;

  final _controllerOfCategories = StreamController.broadcast();
  Sink get sinkOfCategories => _controllerOfCategories.sink;
  Stream get streamOfCategories => _controllerOfCategories.stream;

  CategoryRepository _repository = CategoryRepository();
  CategoryRepository get repository => _repository;

  void addCategory(CategoryModel category) {
    _repository.add(category);
    _sinkingCategories();
  }

  void deleteCategory(CategoryModel category) {
    _repository.delete(category);
    _sinkingCategories();
  }

  void _sinkingCategories() {
    _repository.all().then((categories) {
      sinkOfCategories.add(categories);
    });
  }

  void dispose() {
    _controllerOfCategories.close();
    _controllerOfHome.close();
  }
}
