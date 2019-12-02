import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/controllers/step_manager_contract.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/presentation/shared/widgets/icon_checkbox.dart';

import 'task_controller.dart';

part 'widgets/bottom_bar.dart';
part 'widgets/important_checkbox.dart';
part 'widgets/page_body.dart';
part 'widgets/page_footer.dart';
part 'widgets/page_header.dart';
part 'widgets/step_list_tile.dart';
part 'widgets/step_list_view.dart';
part 'widgets/task_delete_dialog.dart';
part 'widgets/task_note_text_field.dart';
part 'widgets/task_title_text_field.dart';

class TaskPage extends StatefulWidget {
  /// Create a TaskPage widget.
  /// 
  /// The [data] argument must not be null.
  TaskPage({
    Key key,
    @required this.data,
  }): assert(data != null),
      super(key: key);

  final TaskEntity data;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Business Logic Component.
  TaskController controller;
  TaskEntity data;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
    this.controller = TaskController(this.data);
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
    // Close controller component.
    this.controller.dispose();
    super.dispose();
  }

  void changeEntity(TaskEntity entity) {
    this.data = entity;
  }

  /// Build the TaskPage widget with this state.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final component = Component.of<TaskManagerContract>(context);
        await component.updateTask(this.widget.data, this.data);
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
                _PageHeader(
                  data: this.data,
                  onChanged: this.changeEntity,
                ),
                _PageBody(data: this.data),
                _PageFooter(
                  data: this.data,
                  onChanged: this.changeEntity,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: _BottomBar(data: this.data),
    );
  }
}
