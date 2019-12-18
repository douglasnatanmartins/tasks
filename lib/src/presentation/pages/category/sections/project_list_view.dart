part of '../category_layout.dart';

class _ProjectListView extends StatelessWidget {
  /// Create a ProjectListView widget.
  /// 
  /// The [items] argument must not be null.
  _ProjectListView({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<ProjectEntity> items;

  /// Build the ProjectListView widget.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _ProjectCard(data: items.elementAt(index));
      },
    );
  }
}
