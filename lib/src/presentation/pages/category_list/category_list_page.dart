import 'package:flutter/material.dart';

import 'package:tasks/src/core/provider.dart';

import 'category_list_controller.dart';
import 'category_list_layout.dart';

class CategoryListPage extends StatelessWidget {
  /// Create a CategoryListPage widget.
  CategoryListPage({
    Key key,
  }): super(key: key);

  /// Build the CategoryListPage widget.
  @override
  Widget build(BuildContext context) {
    return Provider<CategoryListController>(
      creator: (context) => CategoryListController(),
      disposer: (context, component) => component.dispose(),
      child: CategoryListLayout(),
    );
  }
}
