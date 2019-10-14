import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/pages/project_new/project_new_screen.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'category_page_bloc.dart';
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
  CategoryPageBloc bloc;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.bloc = CategoryPageBloc(this.widget.category);
    this.bloc.refreshProjects();
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: this.widget.category,
      stream: this.bloc.streamCategory,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final CategoryModel category = snapshot.data;
        return this.buildPage(category);
      }
    );
  }

  /// Build a category page.
  Widget buildPage(CategoryModel category) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.headerPage(category),
            this.bodyPage()
          ],
        )
      ),
      // Create new project button.
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-button',
        elevation: 0,
        backgroundColor: Colors.green[600],
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.of(this.context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProjectNewScreen(
                  category: category.id
                );
              }
            )
          );

          if (result is ProjectModel) {
            this.bloc.addProject(result);
          }
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
          fontSize: 22.0
        )
      )
    );

    if (category.description != null && category.description.isNotEmpty) {
      headerTitle.add(
        Text(
          category.description,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle.copyWith(
            fontWeight: FontWeight.w300
          )
        )
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
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
                  child: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(this.context).pop()
                )
              ),
              // Header title.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: headerTitle
                )
              ),
              // Delete button.
              FlatButton(
                padding: const EdgeInsets.all(12.0),
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.white, width: 4.0)
                ),
                color: Colors.red,
                textColor: Colors.white,
                child: const Icon(Icons.delete),
                // Show a dialog to confirm the user wants delete.
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return this._dialogWhenDeleteCategory();
                    }
                  );

                  if (result != null && result) {
                    if (await this.bloc.deleteCategory(category)) {
                      Navigator.of(this.context).pop();
                    }
                  }
                }
              )
            ]
          ),
        ]
      )
    );
  }

  /// Build dialog when delete category.
  Widget _dialogWhenDeleteCategory() {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      content: Text('Are you want delete this category?'),
      actions: <Widget>[
        // Cancel button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0)
          ),
          color: Colors.grey[400],
          textColor: Colors.white,
          child: const Text('Cancel'),
          onPressed: () { // When the user pressed CANCEL button.
            Navigator.of(context).pop(false);
          }
        ),
        // Yes Button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0)
          ),
          color: Theme.of(this.context).errorColor,
          textColor: Colors.white,
          child: const Text('Yes'),
          onPressed: () { // When the user pressed YES button.
            Navigator.of(context).pop(true);
          }
        ),
      ]
    );
  }

  /// Build body this page.
  Widget bodyPage() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: StreamBuilder(
          stream: this.bloc.streamProjects,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.data.isNotEmpty) { // Has the stream data.
                return ProjectListView(
                  data: snapshot.data,
                  whenOpened: () => this.bloc.refreshProjects(),
                );
              } else {
                return EmptyContentBox(message: 'not project found');
              }
            }
          }
        )
      )
    );
  }
}
