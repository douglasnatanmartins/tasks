import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/presentation/pages/category/category_page_bloc.dart';
import 'package:tasks/src/presentation/pages/project/project_page.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/new_project_form.dart';

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
  CategoryPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CategoryPageBloc(category: widget.category);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  /// Build a category page.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: widget.category,
      stream: _bloc.streamCategory,
      builder: (context, snapshot) {
        final CategoryModel category = snapshot.data;
        return Scaffold(
          appBar: _headerPage(category),
          body: _bodyPage(category)
        );
      }
    );
  }

  /// Build header this page.
  Widget _headerPage(CategoryModel category) {
    return AppBar(
      title: Text(category.title),
      actions: <Widget>[
        // Delete category button.
        FlatButton(
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
              _bloc.deleteCategory(category);
              Navigator.of(context).pop();
            }
          }
        )
      ]
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

  /// Build body this page.
  Widget _bodyPage(CategoryModel category) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Projects',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  )
                ),
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Icon(Icons.add),
                  onPressed: () async { // Show new project dialog.
                    final result = await showDialog(
                      context: context,
                      builder: (context) {
                        return NewProjectForm(category.id);
                      }
                    );

                    if (result is ProjectModel) {
                      _bloc.addProject(result);
                    }
                  }
                )
              ],
            )
          ),
          // The main content this page.
          _mainContent()
        ]
      )
    );
  }

  /// Build main content this page.
  Widget _mainContent() {
    return Container(
      child: Expanded(
        child: StreamBuilder(
          stream: _bloc.streamProjects,
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
      itemCount: projects.length,
      itemBuilder: (context, index) {
        ProjectModel project = projects[index];
        return _buildChildrenInListView(project);
      }
    );
  }

  /// Build a children in listview.
  Widget _buildChildrenInListView(ProjectModel project) {
    return ListTile(
      title: Text(project.title),
      trailing: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor
                      ),
                      title: Text(
                        'Delete',
                      )
                    )
                  )
                ];
              },
              onSelected: (action) {
                if (action == 'delete') {
                  _bloc.deleteProject(project);
                }
              },
            )
          ]
        )
      ),
      onTap: () { // Open a project page.
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
