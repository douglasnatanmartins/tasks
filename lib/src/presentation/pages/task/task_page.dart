import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';

import 'task_controller.dart';
import 'widgets/bottom_bar.dart';
import 'widgets/page_body.dart';
import 'widgets/page_footer.dart';
import 'widgets/page_header.dart';

class TaskPage extends StatefulWidget {
  /// Create a TaskPage widget.
  /// 
  /// The [data] argument must not be null.
  TaskPage({
    Key key,
    @required this.model,
  }): assert(model != null),
      super(key: key);

  final TaskModel model;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Business Logic Component.
  TaskController controller;
  TaskModel model;
  String title;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.model = this.widget.model;
    this.title = this.model.title;
    this.controller = TaskController(this.model);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskPage old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.controller.dispose();
    super.dispose();
  }

  void changeModel(TaskModel model) {
    this.model = model;
  }

  /// Build the TaskPage widget with this state.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final component = Component.of<TasksControllerInterface>(context);
        await component.updateTask(this.model);
        return true;
      },
      child: Component<TaskController>.value(
        value: this.controller,
        child: this.buildPage(),
      ),
    );
  }

  /// Build a task page.
  Widget buildPage() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                PageHeader(model: this.model),
                PageBody(model: this.model),
                PageFooter(model: this.model),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomBar(model: this.model),
    );
  }
}
