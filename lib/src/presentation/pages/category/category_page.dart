import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/pages/project/project_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/forms/new_project_form.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

import 'category_page_bloc.dart';
import 'widgets/project_card.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel category;

  CategoryPage({
    Key key,
    @required this.category
  }): assert(category != null), super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryPageState();
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
      backgroundColor: UIColors.Blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.headerPage(category),
            this.bodyPage()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'floating-button',
        elevation: 0,
        backgroundColor: UIColors.Green,
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewProjectForm(categoryId: category.id);
            }
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
                  padding: EdgeInsets.all(10.0),
                  shape: CircleBorder(),
                  textColor: UIColors.Blue,
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
                  children: <Widget>[
                    Text(
                      category.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                      )
                    )
                  ]
                )
              ),
              // Delete button.
              FlatButton(
                padding: EdgeInsets.all(12.0),
                shape: CircleBorder(
                  side: BorderSide(color: Colors.white, width: 4.0)
                ),
                color: UIColors.Blue,
                textColor: Colors.white,
                child: Icon(Icons.delete),
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
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Text(
              'Projects',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600
              )
            )
          )
        ]
      )
    );
  }

  /// Build dialog when delete category.
  Widget _dialogWhenDeleteCategory() {
    return AlertDialog(
      content: Text('Are you want delete this category?'),
      actions: <Widget>[
        // Yes Button.
        FlatButton(
          color: Theme.of(this.context).errorColor,
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.white)
          ),
          onPressed: () { // When the user pressed YES button.
            Navigator.of(context).pop(true);
          }
        ),
        // Cancel button.
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.grey)
          ),
          onPressed: () { // When the user pressed CANCEL button.
            Navigator.of(context).pop(false);
          }
        )
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
                return this.buildListView(snapshot.data);
              } else {
                return EmptyContentBox(message: 'not project found');
              }
            }
          }
        )
      )
    );
  }

  /// Build the listview to show projects.
  Widget buildListView(List<Map<String, dynamic>> projects) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        final project = projects[index];
        return this._buildChildrenInListView(project['project'], project['progress']);
      }
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInListView(ProjectModel project, double progress) {
    return GestureDetector(
      child: ProjectCard(
        project: project,
        progress: progress,
      ),
      onTap: () {
        Navigator.of(this.context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => ProjectPage(project: project)
          )
        ).then((_) => this.bloc.refreshProjects());
      }
    );
  }
}
