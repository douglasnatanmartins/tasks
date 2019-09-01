import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';
import 'package:tasks/src/domain/entities/project_entity.dart';
import 'package:tasks/src/presentation/screen/project_detail/project_detail_screen.dart';
import 'category_detail_screen_bloc.dart';

class CategoryDetailScreen extends StatefulWidget {
  final CategoryEntity category;

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

  Widget _buildUI(BuildContext context, CategoryEntity category) {
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
                        child: Text("Yes"),
                        onPressed: () {
                          Navigator.of(context).pop("yes");
                        },
                      ),
                      FlatButton(
                        child: Text("Cancel"),
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
                      if (result is ProjectEntity) {
                        _bloc.addProject(result);
                      }
                    },
                  )
                ],
              )
            ),
            Expanded(
              child: StreamBuilder(
                initialData: category.projects,
                stream: _bloc.streamOfProjects,
                builder: (context, snapshot) {
                  final List<ProjectEntity> source = snapshot.data;
                  return ListView.builder(
                    itemCount: source.length,
                    itemBuilder: (context, index) {
                      final project = source[index];
                      return ListTile(
                        leading: Icon(Icons.list),
                        title: Text(project.title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectDetailScreen(project: project)
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
              )
            )
          ],
        )
      )
    );
  }

  _buildForm(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        final _titleController = new TextEditingController();
        final _descriptionController = new TextEditingController();
        return Dialog(
          child: Container(
            width: 360,
            height: 240,
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: <Widget>[
                  Text(
                    "New List",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  Flexible(
                    child: TextFormField(
                      autofocus: true,
                      controller: _titleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Title"
                      )
                    )
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: "Description"
                      )
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
                          ProjectEntity project = ProjectEntity(
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim()
                          );
                          Navigator.of(context).pop(project);
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
