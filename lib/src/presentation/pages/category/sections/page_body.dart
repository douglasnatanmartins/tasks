part of '../category_layout.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
  }) : super(key: key);

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CategoryController>(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: StreamBuilder(
          stream: controller.projects,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                // Has the stream data.
                return _ProjectListView(items: snapshot.data);
              } else {
                return EmptyContentBox(
                  title: 'no project created yet',
                  description: 'click green button to get started',
                );
              }
            }
          },
        ),
      ),
    );
  }
}
