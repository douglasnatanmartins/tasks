import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/pages/category/category_page_bloc.dart';
import 'package:tasks/src/presentation/pages/project/project_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/forms/new_project_form.dart';
import 'package:tasks/src/presentation/shared/cards/project_card.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class CategoryPage extends StatefulWidget {
  final CategoryModel category;

  CategoryPage({
    Key key,
    @required this.category
  }): assert(category != null), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryPageBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = CategoryPageBloc(category: widget.category);
    this.bloc.refreshProjects();
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  /// Build a category page.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: widget.category,
      stream: this.bloc.streamCategory,
      builder: (context, snapshot) {
        final CategoryModel category = snapshot.data;
        return buildPage(context, category);
      }
    );
  }

  Widget buildPage(BuildContext context, CategoryModel category) {
    return Scaffold(
      body: bodyPage(category),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: UIColors.Green,
        child: Icon(Icons.add),
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) {
              return NewProjectForm(category.id);
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

  /// Build body this page.
  Widget bodyPage(CategoryModel category) {
    return Container(
      child: Column(
        children: <Widget>[
          // Header this page.
          headerPage(category),
          // The main content this page.
          bodyContent()
        ]
      )
    );
  }

  /// Build header this page.
  Widget headerPage(CategoryModel category) {
    return Container(
      padding: EdgeInsets.only(top: 35.0),
      decoration: BoxDecoration(
        color: UIColors.Blue
      ),
      height: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Back button.
              FlatButton(
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
                textColor: UIColors.Blue,
                color: Colors.white,
                child: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      category.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                      )
                    )
                  ]
                )
              ),
              FlatButton(
                padding: EdgeInsets.all(12.0),
                shape: CircleBorder(side: BorderSide(color: Colors.white, width: 4.0)),
                color: UIColors.Blue,
                textColor: Colors.white,
                child: Icon(Icons.delete),
                onPressed: () async { // Show dialog to confirm the user wants delete.
                  final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return _dialogWhenDeleteCategory();
                    }
                  );

                  if (result != null && result) {
                    this.bloc.deleteCategory(category);
                    Navigator.of(context).pop();
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
      content: Text("Are you want delete this category?"),
      actions: <Widget>[
        // Yes Button.
        FlatButton(
          color: Theme.of(context).errorColor,
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white)
          ),
          onPressed: () { // When the user pressed YES button.
            Navigator.of(context).pop(true);
          }
        ),
        // Cancel button.
        FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.grey)
          ),
          onPressed: () { // When the user pressed CANCEL button.
            Navigator.of(context).pop(false);
          }
        )
      ]
    );
  }

  /// Build main content this page.
  Widget bodyContent() {
    return Container(
      child: Expanded(
        child: StreamBuilder(
          stream: this.bloc.streamProjects,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.data.isNotEmpty) { // Has the stream data.
                return _buildListView(snapshot.data);
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
  Widget _buildListView(List<ProjectModel> projects) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        final project = projects[index];
        return _buildChildrenInListView(project);
      }
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInListView(ProjectModel project) {
    return GestureDetector(
      child: ProjectCard(project: project),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectPage(project: project)
          )
        );
      }
    );
  }
}
