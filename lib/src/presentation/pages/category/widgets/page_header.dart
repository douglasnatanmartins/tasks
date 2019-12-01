part of '../category_page.dart';

class _PageHeader extends StatelessWidget {
  /// Create a _PageHeader widget.
  _PageHeader({
    Key key,
    @required this.data,
  })  : super(key: key);

  final CategoryEntity data;

  /// Build the _PageHeader widget.
  @override
  Widget build(BuildContext context) {
    List<Widget> headerTitle = <Widget>[];
    headerTitle.add(
      Text(
        this.data.title,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.title.copyWith(
          fontSize: 22.0,
        ),
      ),
    );

    if (this.data.description != null && this.data.description.isNotEmpty) {
      headerTitle.add(
        Text(
          this.data.description,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Back button.
              Hero(
                tag: 'previous-screen-button',
                child: FlatButton(
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                  color: Colors.white,
                  child: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Header title.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: headerTitle,
                ),
              ),
              // Delete button.
              Consumer<CategoryManagerContract>(
                builder: (context, component) {
                  return FlatButton(
                    padding: const EdgeInsets.all(12.0),
                    shape: const CircleBorder(
                      side: BorderSide(color: Colors.white, width: 4.0),
                    ),
                    color: Colors.red,
                    textColor: Colors.white,
                    child: const Icon(Icons.delete),
                    // Show a dialog to confirm the user wants delete.
                    onPressed: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _CategoryDeleteDialog();
                        },
                      );

                      if (result != null && result) {
                        await component.deleteCategory(this.data);
                        Navigator.of(context).pop();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
