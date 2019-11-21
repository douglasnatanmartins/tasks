import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/presentation/blocs/tasks_bloc.dart';
import 'widgets/page_header.dart';
import 'widgets/task_list_view.dart';

class ImportantPage extends StatelessWidget {
  /// Create a ImportantPage widget.
  ImportantPage({
    Key key,
  }): super(key: key);

  /// Build this widget.
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context, component: TasksBloc);
    bloc.event.add(TaskType.Important);
    return Scaffold(
      appBar: null,
      body: this.buildPage(),
    );
  }

  Widget buildPage() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          this.headerPage(),
          this.bodyPage(),
        ],
      ),
    );
  }

  Widget headerPage() {
    return PageHeader();
  }

  Widget bodyPage() {
    return Expanded(
      child: TaskListView(),
    );
  }
}
