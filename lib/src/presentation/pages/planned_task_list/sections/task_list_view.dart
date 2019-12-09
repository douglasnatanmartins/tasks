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
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      scrollDirection: Axis.vertical,
      itemCount: this.items.length,
      itemBuilder: (BuildContext context, int index) {
        final key = this.items.keys.elementAt(index);
        final data = this.items[key];
        return GroupListTile(
          date: key,
          items: data,
        );
      }
    );
  }
}
