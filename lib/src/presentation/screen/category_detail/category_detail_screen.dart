import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/project_model.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/screen/project_detail/project_detail_screen.dart';
import 'category_detail_screen_bloc.dart';

class CategoryDetailScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryDetailScreen({Key key, @required this.category}):
    assert(category != null),
    super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailScreenState();
  }
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  CategoryDetailScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CategoryDetailScreenBloc(category: widget.category);
  }

  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: widget.category,
      stream: _bloc.streamOfCategory,
      builder: (context, snapshot) {
        return _buildUI(context, snapshot.data);
      }
    );
  }

  Widget _buildUI(BuildContext context, CategoryModel category) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              final result = await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Are you want delete this category?"),
                    actions: <Widget>[
                      FlatButton(
                        color: Colors.red,
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white)
                        ),
                        onPressed: () {
                          Navigator.of(context).pop("yes");
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.grey)
                        ),
                        onPressed: () {
                          Navigator.of(context).pop("cancel");
                        }
                      )
                    ],
                  );
                }
              );

              if (result == "yes") {
                Navigator.of(context).pop(["delete", category]);
              }
            }
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    color: Colors.green,
                    child: Icon(Icons.add, color: Colors.white),
                    onPressed: () async {
                      final result = await _buildForm(context);
                      if (result is ProjectModel) {
                        _bloc.addProject(result);
                      }
                    },
                  )
                ],
              )
            ),
            Expanded(
              child: FutureBuilder(
                future: _bloc.getAllProject(),
                builder: (context, loaded) {
                  if (loaded.hasData) {
                    return StreamBuilder(
                      initialData: loaded.data,
                      stream: _bloc.streamOfProjects,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !snapshot.data.isEmpty) {
                          return _buildListView(snapshot.data);
                        } else {
                          return Center(
                            child: Text("Empty")
                          );
                        }
                      }
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator()
                    );
                  }
                }
              )
            )
          ],
        )
      )
    );
  }

  Widget _buildListView(List<ProjectModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final project = data[index];
        return ListTile(
          leading: Icon(Icons.list),
          title: Text(project.title),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectDetailScreen(project: ProjectEntity(title: "test"))
              )
            );
          },
          trailing: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _bloc.countNotDoneTaskInProject(project).toString(),
                  style: TextStyle(fontSize: 17)
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _bloc.deleteProject(project);
                  }
                )
              ]
            )
          )
        );
      }
    );
  }

  _buildForm(BuildContext context) {
    final _key = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        final _titleController = new TextEditingController();
        final _descriptionController = new TextEditingController();
        return Dialog(
          child: Container(
            width: 360,
            height: 280,
            padding: EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "New List",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: "Title"
                    ),
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return "Please enter project title.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: "Description"
                      )
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        color: Colors.green,
                        child: Text(
                          "Create",
                          style: TextStyle(
                            color: Colors.white
                          )
                        ),
                        onPressed: () {
                          if (_key.currentState.validate()) {
                            ProjectModel project = ProjectModel(
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              categoryId: widget.category.id
                            );
                            Navigator.of(context).pop(project);
                          }
                        }
                      )
                    )
                  )
                ],
              )
            )
          )
        );
      }
    );
  }
}
