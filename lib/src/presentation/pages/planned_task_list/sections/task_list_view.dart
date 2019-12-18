part of '../planned_task_list_layout.dart';

class TaskListView extends StatelessWidget {
  /// Create a TaskListView widget.
  TaskListView({
    Key key,
    @required this.items,
  }): assert(items != null),
      super(key: key);

  final Map<DateTime, List<TaskEntity>> items;

  /// Build the TaskListView widget.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        var key = items.keys.elementAt(index);
        var data = items[key];
        return GroupListTile(
          date: key,
          items: data,
        );
      }
    );
  }
}
