import 'package:flutter/material.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';

import 'category_controller.dart';
import 'category_layout.dart';

class CategoryPage extends StatelessWidget {
  /// Create a CategoryPage widget.
  CategoryPage({
    Key key,
    @required this.data,
  }): super(key: key);

  final CategoryEntity data;

  /// Build the CategoryPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<CategoryController>(
      creator: (context) => CategoryController(data),
      disposer: (context, component) => component.dispose(),
      child: CategoryLayout(
        category: data,
      ),
    );
  }
}
