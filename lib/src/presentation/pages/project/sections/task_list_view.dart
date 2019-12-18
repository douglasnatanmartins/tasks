part of '../project_layout.dart';

class _TaskListView extends StatelessWidget {
  /// Create a TaskListView widget.
  _TaskListView({
    Key key,
    @required this.items,
  }): super(key: key);

  final List<TaskEntity> items;

  /// Build the TaskListView widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectController>(context);

    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: items.length,
      separatorBuilder: (content, index) {
        return Divider(
          color: Colors.white.withOpacity(0.85),
        );
      },
      itemBuilder: (context, index) {
        var item = items.elementAt(index);
        return _TaskListTile(
          data: item,
          onChanged: (entity) {
            controller.updateTask(entity, item);
          },
        );
      },
    );
  }
}
