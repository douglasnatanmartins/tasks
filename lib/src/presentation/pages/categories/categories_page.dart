import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/presentation/shared/forms/category_new_form.dart';

import 'categories_controller.dart';
import 'widgets/page_body.dart';
import 'widgets/page_header.dart';

class CategoriesPage extends StatefulWidget {
  /// Create a CategoriesPage widget.
  CategoriesPage({
    Key key,
  }): super(key: key);

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  CategoriesController controller;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.controller = CategoriesController();
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(CategoriesPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the CategoriesPage widget with state.
  @override
  Widget build(BuildContext context) {
    return Component<CategoriesController>.value(
      value: this.controller,
      child: this.buildPage(),
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            PageHeader(),
            PageBody(),
          ],
        ),
      ),
      floatingActionButton: Consumer<CategoriesController>(
        builder: (context, component) {
          return FloatingActionButton(
            heroTag: 'floating-button',
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.white.withOpacity(0.85),
                width: 3.0,
              ),
            ),
            elevation: 0,
            child: const Icon(Icons.add, size: 30),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CategoryNewForm();
                }
              );

              if (result is CategoryModel) {
                component.addCategory(result);
              }
            },
          );
        },
      ),
    );
  }
}
