part of '../important_task_list_layout.dart';

class _PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  _PageBody({
    Key key,
  }) : super(key: key);

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ImportantTaskListController>(context);

    return Expanded(
      child: StreamBuilder<List<TaskEntity>>(
        stream: controller.tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return _TaskListView(items: snapshot.data);
            } else {
              return EmptyContentBox(
                title: 'no important task created yet',
              );
            }
          }
        },
      ),
    );
  }
}
