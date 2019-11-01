import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';

import 'category_card.dart';

class CategoryListView extends StatefulWidget {
  CategoryListView({
    Key key,
    @required this.data,
    @required this.whenOpened
  }): assert(data != null),
      assert(whenOpened != null),
      super(key: key);

  final List<CategoryModel> data;
  final Function whenOpened;

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  List<CategoryModel> categories;

  @override
  void initState() {
    super.initState();
    this.categories = this.widget.data;
  }

  /// Call when widget update.
  @override
  void didUpdateWidget(CategoryListView oldWidget) {
    if (oldWidget.data != this.widget.data) {
      this.categories = this.widget.data;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.8,
      ),
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return this.buildItem(categories[index]);
      },
    );
  }

  Widget buildItem(CategoryModel category) {
    return GestureDetector(
      child: CategoryCard(
          key: UniqueKey(),
          category: category,
        ),
      onTap: () {
        Navigator.of(this.context).pushNamed('/category', arguments: category)
          .then((result) => this.widget.whenOpened());
      },
    );
  }
}
