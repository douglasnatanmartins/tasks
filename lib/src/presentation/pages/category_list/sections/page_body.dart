part of '../category_list_layout.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
  }) : super(key: key);

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryListController>(context);
    return Expanded(
      child: StreamBuilder(
        stream: controller.categories,
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
