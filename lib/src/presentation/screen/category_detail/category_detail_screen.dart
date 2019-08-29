import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/category_model.dart';
import 'package:tasks/src/data/models/task_list_model.dart';
import 'package:tasks/src/presentation/screen/task_list_detail/task_list_detail_screen.dart';
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
      stream: _bloc.stream,
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
            onPressed: () {}
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
                      if (result is TaskListModel) {
                        _bloc.addNewList(result);
                      }
                    },
                  )
                ],
              )
            ),
            Expanded(
              child: StreamBuilder(
                initialData: category.allList,
                stream: _bloc.streamOfList,
                builder: (context, snapshot) {
                  final List<TaskListModel> source = snapshot.data;
                  return ListView.builder(
                    itemCount: source.length,
                    itemBuilder: (context, index) {
                      final list = source[index];
                      return ListTile(
                        leading: Icon(Icons.list),
                        title: Text(list.title),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskListDetailScreen(list: list)
                            )
                          );
                        },
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
                          TaskListModel list = TaskListModel(
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim()
                          );
                          Navigator.of(context).pop(list);
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