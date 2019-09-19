import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/important/important_page_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/bottom_navigation.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/header_home.dart';
import 'package:tasks/src/presentation/shared/widgets/task_list_tile.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class ImportantPage extends StatefulWidget {
  ImportantPage({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImportantPageState();
  }
}

class _ImportantPageState extends State<ImportantPage> {
  final int id = 0;
  ImportantPageBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = ImportantPageBloc();
    this.bloc.refreshImportantTasks();
  }

  @override
  void dispose() {
    this.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildPage(context);
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: bodyPage()
      ),
      bottomNavigationBar: Hero(
        tag: 'bottom-navigation-bar.',
        child: BottomNavigation(context: context, current: this.id)
      )
    );
  }

  Widget bodyPage() {
    return Column(
      children: <Widget>[
        Container(
          height: 120.0,
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
          decoration: BoxDecoration(
            color: UIColors.Blue
          ),
          child: StreamBuilder(
            stream: this.bloc.streamImportantTasks,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return HeaderHome(importantTasks: snapshot.data.length);
              }

              return HeaderHome();
            }
          )
        ),
        Container(
          child: Expanded(
            child: bodyContent()
          )
        )
      ]
    );
  }

  Widget bodyContent() {
    return StreamBuilder(
      stream: this.bloc.streamImportantTasks,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator()
          );
        } else {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            List<TaskModel> data = snapshot.data;
            return _buildListView(data);
          } else {
            return EmptyContentBox(message: 'not important task');
          }
        }
      }
    );
  }

  Widget _buildListView(List<TaskModel> data) {
    List<dynamic> source = ['Important'];
    source.addAll(data);
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      itemCount: source.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildChildrenInListView(source[index]);
      }
    );
  }

  Widget _buildChildrenInListView(dynamic data) {
    if (data is String) {
      return _buildListTileHeader(data);
    } else {
      return _buildListTile(data);
    }
  }

  Widget _buildListTileHeader(String title) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20.0, right: 20.0, bottom: 20.0),
      child: Text(
        title,
        style: TextStyle(
          color: UIColors.Grey,
          fontSize: 16.0,
          fontWeight: FontWeight.w600
        )
      )
    );
  }

  Widget _buildListTile(TaskModel task) {
    return Dismissible(
      direction: DismissDirection.horizontal,
      key: Key(task.id.toString()),
      child: TaskListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.green,
          value: task.done,
          onChanged: (checked) {
            task.done = checked;
            this.bloc.updateTask(task);
          }
        ),
        title: Text(
          task.title,
          style: TextStyle(
            color: UIColors.Blue,
            fontWeight: FontWeight.w600
          )
        )
      ),
      onDismissed: (direction) {
        task.important = false;
        this.bloc.updateTask(task);
      },
    );
  }
}
