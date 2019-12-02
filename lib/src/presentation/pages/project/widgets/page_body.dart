part of '../project_page.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
  }): super(key: key);

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    final controller = Component.of<ProjectController>(context);
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
