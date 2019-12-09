part of '../category_layout.dart';

class _ProjectListView extends StatelessWidget {
  /// Create a _ProjectListView widget.
  _ProjectListView({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<ProjectEntity> items;

  /// Build the _ProjectListView widget.
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      itemCount: this.items.length,
      itemBuilder: (BuildContext context, int index) {
        return _ProjectCard(
          model: this.items.elementAt(index),
        );
      },
    );
  }
}
