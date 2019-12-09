part of '../category_detail_page.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
  }): super(key: key);

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    return Consumer<_Shared>(
      builder: (context, shared) {
        return Container(
          margin: const EdgeInsets.symmetric(),
          padding: const EdgeInsets.symmetric(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _Field(
                label: 'Title',
                controller: shared.titleController,
              ),
              const SizedBox(height: 10.0),
              _Field(
                label: 'Description',
                controller: shared.descriptionController,
              ),
            ],
          ),
        );
      },
    );
  }
}
