import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';

import 'item_list_tile.dart';

class TaskListView extends StatefulWidget {
  TaskListView({
    Key key,
    @required this.data,
    @required this.onChanged,
    this.whenOnTap
  }): assert(data != null),
      assert(onChanged != null),
      super(key: key);
  
  final List<TaskModel> data;

  /// When item changed.
  final ValueChanged<TaskModel> onChanged;

  /// After open task page
  final Function whenOnTap;

  @override
  State<StatefulWidget> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  List<TaskModel> data;

  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
  }

  @override
  void didUpdateWidget(TaskListView oldWidget) {
    if (oldWidget.data.length != this.widget.data.length) {
      this.data = this.widget.data;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: this.data.length,
      itemBuilder: (BuildContext context, int index) {
        final TaskModel task = this.data.elementAt(index);

        return ItemListTile(
          key: Key(task.id.toString()),
          task: task,
          onChanged: (TaskModel newTask) {
            this.widget.onChanged(newTask);

            if (!newTask.important) {
              setState(() {
                this.data.removeAt(index);
                if (this.data.length == 0) {
                  this.widget.whenOnTap();
                }
              });
            }
          },
          whenOnTap: this.widget.whenOnTap,
        );
      },
    );
  }
}
