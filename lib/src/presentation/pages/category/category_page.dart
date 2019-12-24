import 'package:flutter/material.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';

import '../../controllers/category_manager_contract.dart';
import 'category_controller.dart';
import 'category_layout.dart';

class CategoryPageArguments {
  CategoryPageArguments({
    this.key,
    @required this.category,
    @required this.manager,
  }): assert(category != null),
      assert(manager != null);

  final Key key;
  final CategoryEntity category;
  final CategoryManagerContract manager;
}

class CategoryPage extends StatelessWidget {
  /// Create a CategoryPage widget.
  /// 
  /// The [arguments] argument must not be null.
  CategoryPage({
    @required this.arguments,
  }): assert(arguments != null),
      super(key: arguments.key);

  final CategoryPageArguments arguments;

  /// Build the CategoryPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<CategoryController>(
      creator: (context) {
        return CategoryController(
          category: arguments.category,
          manager: arguments.manager,
        );
      },
      disposer: (context, controller) => controller?.dispose(),
      child: CategoryLayout(),
    );
  }
}
