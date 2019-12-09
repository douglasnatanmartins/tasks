import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/controllers/category_manager_contract.dart';
import 'package:tasks/src/presentation/pages/category_detail/category_detail_page.dart';
import 'package:tasks/src/presentation/pages/project_detail/project_detail_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_controller.dart';

class CategoryPage extends StatefulWidget {
  /// Create a CategoryPage widget.
  CategoryPage({
    Key key,
    @required this.data,
  })  : super(key: key);

  final CategoryEntity data;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryController controller;
  CategoryEntity category;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();

    this.category = this.widget.data;
    this.controller = CategoryController(this.category);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(CategoryPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  /// Build the CategoryPage widget with state.
  @override
  Widget build(BuildContext context) {
    return Provider<CategoryController>.component(
      component: this.controller,
      child: this.buildPage(),
    );
  }

  Widget buildPage() {
    return Builder(
      builder: (BuildContext context) {

      },
    );
  }
}
