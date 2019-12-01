part of '../categories_page.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
  }) : super(key: key);

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    final component = Component.of<CategoriesController>(context);
    return Expanded(
      child: StreamBuilder(
        stream: component.categories,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return _CategoryListView(items: snapshot.data);
            } else {
              return EmptyContentBox(
                title: 'not category created yet',
                description: 'click the add button to get started',
              );
            }
          }
        },
      ),
    );
  }
}
