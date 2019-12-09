part of '../important_task_list_layout.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
  }) : super(key: key);

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ImportantTaskListController>(context);
    return Expanded(
      child: StreamBuilder(
        stream: controller.tasks,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
