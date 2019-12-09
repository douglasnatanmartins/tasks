part of '../planned_task_list_layout.dart';

class PageBody extends StatelessWidget {
  /// Create a PageBody widget.
  PageBody({
    Key key,
  }): super(key: key);

  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PlannedTaskListController>(context);
    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: controller.tasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                return TaskListView(
                  items: snapshot.data,
                );
              } else {
                return EmptyContentBox(
                  title: 'no planned task created yet',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
