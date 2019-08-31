import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';

import 'home_screen_bloc.dart';
import 'package:tasks/src/presentation/screen/category_detail/category_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenBloc _bloc;

  _HomeScreenState() {
    _bloc = HomeScreenBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.streamOfHome,
      builder: (context, snapshot) {
        return _buildUI(context, snapshot.data);
      }
    );
  }

  Widget _buildUI(BuildContext context, data) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        centerTitle: true
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 32
                        )
                      )
                    ),
                    Expanded(
                      child: FlatButton(
                        color: Colors.green,
                        child: Icon(Icons.add, color: Colors.white),
                        onPressed: () async {
                          final result = await _buildForm(context);
                          if (result is CategoryEntity) {
                            _bloc.addCategory(result);
                          }
                        }
                      )
                    )
                  ],
                )
              ),
              Container(
                child: Expanded(
                  child: StreamBuilder(
                    stream: _bloc.streamOfCategories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data is List<CategoryEntity>) {
                        return _buildListView(snapshot.data);
                      } else {
                        return Center(
                          child: Text(
                            "Empty",
                            style: TextStyle(
                              fontSize: 16
                            )
                          )
                        );
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

  Widget _buildListView(List<CategoryEntity> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          leading: Icon(Icons.book),
          title: Text(
            category.title
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(category: category)
              )
            );
          }
        );
      }
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
                    "New Category",
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
                          CategoryEntity category = CategoryEntity(
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim()
                          );
                          Navigator.of(context).pop(category);
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
