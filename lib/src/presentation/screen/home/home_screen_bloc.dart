import 'dart:async';
import 'package:tasks/src/data/models/category_model.dart';

class HomeScreenBloc {
  final _action = StreamController.broadcast();
  Sink get action => _action.sink;
  Stream get stream => _action.stream;
  List<CategoryModel> _categories = [];

  void onAdd(CategoryModel category) {
    _categories.add(category);
    passData();
  }

  void passData() {
    action.add(_categories);
  }

  void dispose() {
    _action.close();
  }
}
