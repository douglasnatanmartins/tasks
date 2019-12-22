part of '../category_layout.dart';

class PageBody extends StatelessWidget {
  /// Build the PageBody widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<CategoryController>(context);

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder<List<ProjectEntity>>(
          initialData: controller.projects,
          stream: controller.projectListStream,
          builder: (context, snapshot) {
            var projects = snapshot.data;
            if (projects != null && projects.isNotEmpty) {
              return ProjectListView(items: snapshot.data);
            } else {
              return EmptyContentBox(
                title: 'no project created yet',
                description: 'click green button to get started',
              );
            }
          },
        ),
      ),
    );
  }
}
