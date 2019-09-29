import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
import 'package:tasks/src/presentation/shared/widgets/bottom_navigation.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/shared/widgets/header_home.dart';
import 'package:tasks/src/presentation/shared/widgets/task_list_tile.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Business Logic Component
  HomePageBloc bloc;
  final int id = 0;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.bloc = HomePageBloc();
    this.bloc.refreshTasks();
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
    return this.buildPage();
  }

  /// Build a home page.
  Widget buildPage() {
    return Scaffold(
      backgroundColor: UIColors.Blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            this.headerPage(),
            this.bodyPage()
          ],
        )
      ),
      bottomNavigationBar: BottomNavigation(context: this.context, current: this.id)
    );
  }

  /// Build header this page.
  Widget headerPage() {
    return StreamBuilder(
      stream: this.bloc.streamTasks,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return HeaderHome(importantTasks: snapshot.data.length);
        }

        return HeaderHome();
      }
    );
  }

  /// Build body this page.
  Widget bodyPage() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: this.bloc.streamTasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                List<dynamic> data = snapshot.data;
                return this.buildListView(data);
              } else {
                return EmptyContentBox(message: 'not important task');
              }
            }
          }
        )
      ),
    );
  }

  /// Build the list view.
  Widget buildListView(List<dynamic> data) {
    return ListView.builder(
      padding: EdgeInsets.all(0.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return this._buildChildrenInListView(data[index]);
      }
    );
  }

  /// Build children in list view.
  Widget _buildChildrenInListView(dynamic data) {
    if (data is String) {
      return this._buildListTileHeader(data);
    } else {
      return this._buildListTile(data);
    }
  }

  /// Build header type in list view.
  Widget _buildListTileHeader(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Text(
        title,
        style: TextStyle(
          color: UIColors.DarkBlue,
          fontSize: 17.0,
          fontWeight: FontWeight.w600
        )
      )
    );
  }

  /// Build item type in list view.
  Widget _buildListTile(TaskModel task) {
    return Dismissible(
      direction: DismissDirection.horizontal,
      key: Key(task.id.toString()),
      child: TaskListTile(
        task: task,
        onChanged: (TaskModel changed) {
          this.bloc.updateTask(changed);
        }
      ),
      onDismissed: (DismissDirection direction) {
        task.dueDate = null;
        this.bloc.updateTask(task);
      },
    );
  }
}
