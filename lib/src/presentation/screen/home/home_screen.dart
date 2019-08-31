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
      body: _buildBody(context)
    );
  }

  _getMonthLabel(int month) {
    String label;
    switch (month) {
      case 1: label = "January"; break;
      case 2: label = "February"; break;
      case 3: label = "March"; break;
      case 4: label = "April"; break;
      case 5: label = "May"; break;
      case 6: label = "June"; break;
      case 7: label = "July"; break;
      case 8: label = "August"; break;
      case 9: label = "September"; break;
      case 10: label = "October"; break;
      case 11: label = "November"; break;
      case 12: label = "December"; break;
      default: label = "Month"; break;
    }
    return label;
  }

  Widget _buildBody(BuildContext context) {
    DateTime now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          width: 340,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  _getMonthLabel(now.month),
                  style: TextStyle(
                    fontSize: 72,
                    color: Color.fromRGBO(30, 40, 50, 0.25)
                  )
                )
              ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  now.day.toString(),
                  style: TextStyle(
                    fontSize: 48,
                    color: Color.fromRGBO(20, 150, 20, 0.25)
                  )
                )
              )
            ],
          )
        ),
        Divider(height: 5, color: Color.fromRGBO(10, 20, 30, 0.5)),
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
          subtitle: Text(category.description),
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
