import 'dart:async';

import 'package:tasks/src/domain/entities/category_entity.dart';

class HomeScreenBloc {
  final _controllerOfHome = StreamController.broadcast();
  Sink get sinkOfHome => _controllerOfHome.sink;
  Stream get streamOfHome => _controllerOfHome.stream;

  final _controllerOfCategories = StreamController.broadcast();
  Sink get sinkOfCategories => _controllerOfCategories.sink;
  Stream get streamOfCategories => _controllerOfCategories.stream;

  List<CategoryEntity> _categories = [];

  void addCategory(CategoryEntity category) {
    _categories.add(category);
    _sinkingCategories();
  }

  void removeCategory(CategoryEntity category) {
    _categories.remove(category);
    _sinkingCategories();
  }

  void _sinkingCategories() => sinkOfCategories.add(_categories);

  void dispose() {
    _controllerOfCategories.close();
    _controllerOfHome.close();
  }
}
