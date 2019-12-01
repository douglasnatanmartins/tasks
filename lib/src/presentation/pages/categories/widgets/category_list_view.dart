part of '../categories_page.dart';

class _CategoryListView extends StatelessWidget {
  /// Create a _CategoryListView widget.
  _CategoryListView({
    Key key,
    @required this.items,
  }): super(key: key);

  final List<CategoryEntity> items;

  /// Build the _CategoryListView widget.
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.8,
      ),
      itemCount: this.items.length,
      itemBuilder: (BuildContext context, int index) {
        return _CategoryCard(
          data: this.items.elementAt(index),
        );
      },
    );
  }
}
