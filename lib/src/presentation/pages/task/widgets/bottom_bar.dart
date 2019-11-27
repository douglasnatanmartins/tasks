import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/controllers/tasks_controller_interface.dart';

import 'task_delete_dialog.dart';

class BottomBar extends StatelessWidget {
  /// Create a BottomBar widget.
  BottomBar({
    Key key,
    @required this.model,
  }): super(key: key);

  final TaskModel model;

  /// Build the BottomBar widget.
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Created on ${DateFormat.yMMMd().format(this.model.createdDate)}',
              style: Theme.of(context).textTheme.subtitle.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            // Delete task button.
            Consumer<TasksControllerInterface>(
              builder: (context, component) {
                return IconButton(
                  color: Colors.red[400],
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TaskDeleteDialog();
                      },
                    );

                    if (result != null && result) {
                      if (await component.deleteTask(this.model)) {
                        Navigator.of(context).pop();
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
