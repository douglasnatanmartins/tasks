import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/controllers/step_manager_contract.dart';
import 'package:tasks/src/presentation/controllers/task_manager_contract.dart';
import 'package:tasks/src/presentation/pages/task/task_controller.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/presentation/shared/widgets/icon_checkbox.dart';

part 'sections/bottom_bar.dart';
part 'sections/important_checkbox.dart';
part 'sections/page_body.dart';
part 'sections/page_footer.dart';
part 'sections/page_header.dart';
part 'sections/step_list_tile.dart';
part 'sections/step_list_view.dart';
part 'sections/task_delete_dialog.dart';
part 'sections/task_note_text_field.dart';
part 'sections/task_title_text_field.dart';

class TaskLayout extends StatefulWidget {
  /// Create a TaskLayout widget.
  TaskLayout({
    Key key,
    @required this.task,
  }): super(key: key);

  final TaskEntity task;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskLayout> createState() => _TaskLayoutState();
}

class _TaskLayoutState extends State<TaskLayout> {
  TaskEntity data;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    data = widget.task;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskLayout old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  void onChanged(TaskEntity data) {
    this.data = data;
  }

  /// Build the TaskLayout widget with state.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final manager = Provider.of<TaskManagerContract>(context);
        if (data != widget.task) {
          await manager.updateTask(data, widget.task);
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  _PageHeader(
                    data: data,
                    onChanged: onChanged,
                  ),
                  _PageBody(data: data),
                  _PageFooter(
                    data: data,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        bottomNavigationBar: _BottomBar(data: data),
      ),
    );
  }
}
