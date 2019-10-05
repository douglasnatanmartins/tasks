import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/bottom_navigation.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

import 'home_page_bloc.dart';
import 'widgets/page_header.dart';
import 'widgets/item_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key
  }): super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
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
    return PageHeader();
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
                return this.buildListView(snapshot.data);
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
      key: Key(task.id.toString()),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Icon(Icons.clear, size: 25.0, color: Colors.white),
            SizedBox(width: 5.0),
            Text(
              'Delete',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white
              )
            )
          ],
        )
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.check, size: 25.0, color: Colors.white),
            SizedBox(width: 5.0),
            Text(
              'Completed',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white
              )
            )
          ],
        )
      ),
      direction: DismissDirection.horizontal,
      child: ItemListTile(
        task: task,
        onChanged: (bool checked) {
          task.done = checked;
          this.bloc.updateTask(task);
        }
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          task.done = true;
          task.dueDate = null;
          this.bloc.updateTask(task);
        }
      },
    );
  }
}
