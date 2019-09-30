import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/pages/home/home_page_bloc.dart';
import 'package:tasks/src/presentation/pages/home/widgets/home_page_header.dart';
import 'package:tasks/src/presentation/pages/home/widgets/home_page_task_list_tile.dart';
import 'package:tasks/src/presentation/shared/widgets/bottom_navigation.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
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
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          final List<TaskModel> today = snapshot.data['Today'];
          return HomePageHeader(todayTasks: today?.length);
        }

        return HomePageHeader();
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
                Map<String, List<TaskModel>> data = snapshot.data;
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
  Widget buildListView(Map<String, List<TaskModel>> data) {
    List<Widget> children = <Widget>[];

    data.forEach((String name, List<TaskModel> tasks) {
      children.add(this.buildHeaderListTile(name));
      tasks.forEach((TaskModel task) {
        children.add(this.buildItemListTile(task));
      });
    });

    return ListView(
      padding: EdgeInsets.all(0.0),
      children: children,
    );
  }

  /// Build header type in list view.
  Widget buildHeaderListTile(String title) {
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
  Widget buildItemListTile(TaskModel task) {
    return Dismissible(
      direction: DismissDirection.horizontal,
      key: Key(task.id.toString()),
      child: HomePageTaskListTile(
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
