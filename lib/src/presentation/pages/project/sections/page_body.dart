part of '../project_layout.dart';

class PageBody extends StatelessWidget {
  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProjectController>(context);

    return Expanded(
      child: Container(
        child: StreamBuilder(
          stream: controller.taskListStream,
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
                  title: 'no task created yet',
                  description: 'click add button to get started',
                  textColor: Colors.white.withOpacity(0.75),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
