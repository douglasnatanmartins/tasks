import 'package:flutter/material.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/task_list_tile.dart';

import '../planned_controller.dart';

class GroupListTile extends StatefulWidget {
  GroupListTile({
    Key key,
    @required this.title,
    @required this.items,
  }): assert(title != null),
      assert(items != null),
      super(key: key);

  final String title;
  final List<TaskModel> items;

  @override
  State<GroupListTile> createState() => _GroupListTileState();
}

class _GroupListTileState extends State<GroupListTile> {
  String title;
  List<TaskModel> items;

  @override
  void initState() {
    super.initState();
    this.title = this.widget.title;
    this.items = this.widget.items;
  }

  @override
  void didUpdateWidget(GroupListTile oldWidget) {
    if (oldWidget.items.length != this.widget.items.length) {
      this.items = this.widget.items;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final component = Component.of<PlannedController>(context);
    return Theme(
      data: Theme.of(this.context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(this.title),
        children: this.buildChildren(component),
      ),
    );
  }

  List<Widget> buildChildren(PlannedController component) {
    List<Widget> children = <Widget>[];

    this.items.forEach((TaskModel item) {
      int index = this.items.indexOf(item);
      children.add(
        GestureDetector(
          child: TaskListTile(
            data: item,
            onChanged: (TaskModel updated) {
              component.updateTask(updated);
            },
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/task',
              arguments: <String, dynamic>{
                'component': component,
                'model': item,
              },
            );
          },
        ),
      );

      if (index != this.items.length - 1) {
        children.add(
          Divider(
            color: Color(0xff989898),
          ),
        );
      }
    });

    return children;
  }
}
