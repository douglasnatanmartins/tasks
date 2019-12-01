part of '../project_page.dart';

class _TaskListView extends StatelessWidget {
  /// Create a _TaskListView widget.
  _TaskListView({
    Key key,
    @required this.items,
  }): super(key: key);

  final List<TaskEntity> items;

  /// Build the _TaskListView widget.
  @override
  Widget build(BuildContext context) {
    final controller = Component.of<ProjectController>(context);
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: this.items.length,
      separatorBuilder: (BuildContext content, int index) {
        return Divider(
          color: Colors.white.withOpacity(0.85),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final item = this.items.elementAt(index);
        return _TaskListTile(
          data: item,
          onChanged: (TaskEntity entity) {
            controller.updateTask(item, entity);
          },
        );
      },
    );
  }
}
