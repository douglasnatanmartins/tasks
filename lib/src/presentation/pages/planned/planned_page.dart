import 'package:flutter/material.dart';

import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/bottom_navigation.dart';
import 'package:tasks/src/presentation/shared/widgets/empty_content_box.dart';

import 'planned_page_bloc.dart';
import 'widgets/page_header.dart';
import 'widgets/task_list_view.dart';

class PlannedPage extends StatefulWidget {
  PlannedPage({
    Key key
  }): super(key: key);

  @override
  State<PlannedPage> createState() => _PlannedPageState();
}

class _PlannedPageState extends State<PlannedPage> {
  final String route = '/';
  // Business Logic Component
  PlannedPageBloc bloc;

  /// Called when this state inserted into tree.
  @override
  void initState() {
    super.initState();
    this.bloc = PlannedPageBloc();
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
    return Scaffold(
      body: this.buildPage()
    );
  }

  /// Build a home page.
  Widget buildPage() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          this.headerPage(),
          this.bodyPage()
        ],
      ),
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
        child: StreamBuilder(
          stream: this.bloc.streamTasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator()
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return this.buildListView(snapshot.data);
              } else {
                return EmptyContentBox(message: 'NO TASK');
              }
            }
          }
        )
      ),
    );
  }

  /// Build the list view.
  Widget buildListView(Map<String, List<TaskModel>> data) {
    return TaskListView(
      data: data,
      onChanged: (TaskModel task) {
        this.bloc.updateTask(task);
      }
    );
  }
}
