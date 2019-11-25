import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';

import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  /// Create a CategoryListView widget.
  CategoryListView({
    Key key,
    @required this.items,
  }): super(key: key);

  final List<CategoryModel> items;

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.8,
      ),
      itemCount: this.items.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoryCard(
          category: this.items[index],
        );
      },
    );
  }
}
