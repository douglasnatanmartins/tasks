import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/controllers/category_manager_contract.dart';
import 'package:tasks/src/presentation/pages/category/widgets/category_delete_dialog.dart';
import 'package:tasks/src/presentation/pages/project_new/project_new_screen.dart';

import 'category_controller.dart';
import 'widgets/page_body.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({
    Key key,
    @required this.category
  }): assert(category != null),
      super(key: key);

  final CategoryEntity category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Business Logic Component.
  CategoryController controller;
  CategoryEntity category;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.category = this.widget.category;
    this.controller = CategoryController(this.category);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return Component<CategoryController>.value(
      value: this.controller,
      child: this.buildPage(),
    );
  }

  /// Build a category page.
  Widget buildPage() {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.headerPage(this.widget.category),
            PageBody(),
          ],
        ),
      ),
      // Create new project button.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-button',
        elevation: 0,
        backgroundColor: Colors.green[600],
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.of(this.context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProjectNewScreen(
                  category: this.category.id,
                );
              },
            ),
          );

          if (result is ProjectEntity) {
            this.controller.addProject(result);
          }
        },
      ),
    );
  }

  /// Build header this page.
  Widget headerPage(CategoryEntity category) {
    List<Widget> headerTitle = <Widget>[];
    headerTitle.add(
      Text(
        category.title,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(this.context).textTheme.title.copyWith(
          fontSize: 22.0,
        ),
      ),
    );

    if (category.description != null && category.description.isNotEmpty) {
      headerTitle.add(
        Text(
          category.description,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Back button.
              Hero(
                tag: 'previous-screen-button',
                child: FlatButton(
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                  color: Colors.white,
                  child: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(this.context).pop(),
                ),
              ),
              // Header title.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: headerTitle,
                ),
              ),
              // Delete button.
              Consumer<CategoryManagerContract>(
                builder: (context, component) {
                  return FlatButton(
                    padding: const EdgeInsets.all(12.0),
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.white, width: 4.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    child: const Icon(Icons.delete),
                    // Show a dialog to confirm the user wants delete.
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CategoryDeleteDialog();
                        }
                      );

                      if (result != null && result) {
                        await component.deleteCategory(category);
                        Navigator.of(this.context).pop();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
