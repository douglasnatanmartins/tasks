import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

import '../project_controller.dart';

class TaskListTile extends StatefulWidget {
  /// Create a TaskListTile widget.
  /// 
  /// The [data] and [onChanged] arguments must not be null.
  TaskListTile({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): assert(data != null),
      assert(onChanged != null),
      super(key: key);

  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  TaskEntity data;
  TextDecoration decoration;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskListTile old) {
    if (old.data != this.widget.data) {
      this.data = this.widget.data;
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the TaskListTile widget with state.
  @override
  Widget build(BuildContext context) {
    if (this.data.isDone) {
      this.decoration = TextDecoration.lineThrough;
    } else {
      this.decoration = TextDecoration.none;
    }

    return ListTile(
      leading: CircleCheckbox(
        value: this.data.isDone,
        onChanged: (bool checked) {
          setState(() {
            this.data = this.data.copyWith(isDone: checked);
            this.widget.onChanged(this.data);
          });
        }
      ),
      title: Text(
        this.data.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          decoration: decoration,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: this.data.isImportant ? Colors.yellow.shade600 : null,
        ),
        onPressed: () {
          setState(() {
            this.data = this.data.copyWith(
              isImportant: !this.data.isImportant
            );
            this.widget.onChanged(this.data);
          });
        },
      ),
      onTap: () {
        final component = Component.of<ProjectController>(context);
        Navigator.of(this.context).pushNamed(
          '/task',
          arguments: <String, dynamic>{
            'component': component,
            'model': this.data,
          },
        );
      },
    );
  }
}
