import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';
import 'package:tasks/src/presentation/pages/task/task_page.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

import '../project_controller.dart';

class TaskListTile extends StatefulWidget {
  TaskListTile({
    Key key,
    @required this.model,
    @required this.onChanged,
  }): assert(model != null),
      super(key: key);

  final TaskModel model;
  final ValueChanged<TaskModel> onChanged;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  TaskModel model;
  TextDecoration decoration;

  @override
  void initState() {
    super.initState();
    this.decoration = TextDecoration.none;
    this.model = this.widget.model;
  }

  @override
  void didUpdateWidget(TaskListTile oldWidget) {
    if (oldWidget.model != this.widget.model) {
      this.model = this.widget.model;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (this.model.done) {
      this.decoration = TextDecoration.lineThrough;
    } else {
      this.decoration = TextDecoration.none;
    }

    return ListTile(
      leading: CircleCheckbox(
        value: this.model.done,
        onChanged: (bool checked) {
          setState(() {
            this.model.done = checked;
            this.widget.onChanged(this.model);
          });
        }
      ),
      title: Text(
        this.model.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          decoration: decoration,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: this.model.important ? Colors.yellow.shade600 : null,
        ),
        onPressed: () {
          setState(() {
            this.model.important = !this.model.important;
            this.widget.onChanged(this.model);
          });
        },
      ),
      onTap: () {
        final component = Component.of<ProjectController>(context);
        Navigator.of(this.context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Component<TasksControllerInterface>.value(
                value: component,
                child: TaskPage(model: this.model),
              );
            }
          ),
        );
      },
    );
  }
}
