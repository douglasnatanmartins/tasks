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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: widget.category,
      stream: _bloc.streamCategory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final CategoryModel category = snapshot.data;
          return Scaffold(
            appBar: _headerPage(category),
            body: _bodyPage(category)
          );
        } else {
          return Scaffold(
            body: Container(
              child: Center(
                child: Text('Something Wrong!')
              )
            )
          );
        }
      }
    );
  }

  Widget _headerPage(CategoryModel category) {
    return AppBar(
      title: Text(category.title),
      actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          child: Icon(Icons.delete),
          onPressed: () async {
            final result = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Are you want delete this category?"),
                  actions: <Widget>[
                    FlatButton(
                      color: Theme.of(context).errorColor,
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white)
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      }
                    ),
                    FlatButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.grey)
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }
                    )
                  ]
                );
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
                  onPressed: () async {
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
          _buildListView()
        ]
      )
    );
  }

  Widget _buildListView() {
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
              if (snapshot.data.isNotEmpty) {
                final List<ProjectModel> projects = snapshot.data;
                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    ProjectModel project = projects[index];
                    return ListTile(
                      title: Text(project.title),
                      trailing: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('0'),
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
