part of '../category_layout.dart';

class ProjectListView extends StatelessWidget {
  /// Create a ProjectListView widget.
  /// 
  /// The [items] argument must not be null.
  ProjectListView({
    Key key,
    @required this.items,
  }): assert(items != null),
      super(key: key);

  final List<ProjectEntity> items;

  /// Build the ProjectListView widget.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ProjectCard(data: items.elementAt(index));
      },
    );
  }
}
