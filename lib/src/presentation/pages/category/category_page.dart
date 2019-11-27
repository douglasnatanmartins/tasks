import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/controllers/categories_controller_interface.dart';
import 'package:tasks/src/presentation/pages/category/widgets/category_delete_dialog.dart';
import 'package:tasks/src/presentation/pages/project_new/project_new_screen.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_controller.dart';
import 'widgets/project_list_view.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({
    Key key,
    @required this.category
  }): assert(category != null),
      super(key: key);

  final CategoryModel category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Business Logic Component.
  CategoryController controller;
  CategoryModel category;

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
            this.bodyPage(),
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

          if (result is ProjectModel) {
            this.controller.addProject(result);
          }
        },
      ),
    );
  }

  /// Build header this page.
  Widget headerPage(CategoryModel category) {
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
              Consumer<CategoriesControllerInterface>(
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

  /// Build body this page.
  Widget bodyPage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: this.controller.projects,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) { // Has the stream data.
                return ProjectListView(items: snapshot.data);
              } else {
                return EmptyContentBox(
                  title: 'no project created yet',
                  description: 'click green button to get started',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
