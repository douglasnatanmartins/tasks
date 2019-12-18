part of '../category_list_layout.dart';

class _CategoryListView extends StatelessWidget {
  /// Create a CategoryListView widget.
  /// 
  /// The [items] argument must not be null.
  _CategoryListView({
    Key key,
    @required this.items,
  }): assert(items != null),
      super(key: key);

  final List<CategoryEntity> items;

  /// Build the CategoryListView widget.
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(
        viewportFraction: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _CategoryCard(data: items.elementAt(index));
      },
    );
  }
}
