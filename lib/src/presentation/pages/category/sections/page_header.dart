part of '../category_layout.dart';

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
        data.title,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.title.copyWith(
          fontSize: 22.0,
        ),
      ),
    );

    if (data.description != null && data.description.isNotEmpty) {
      headerTitle.add(
        Text(
          data.description,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle.copyWith(
            fontWeight: FontWeight.w300,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
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
                  padding: const EdgeInsets.all(10),
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
              // Edit category button.
              Consumer<CategoryManagerContract>(
                builder: (context, manager) {
                  return PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) {
                      return const <PopupMenuEntry<String>>[
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ];
                    },
                    onSelected: (selected) async {
                      if (selected == 'edit') {
                        var updated = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return CategoryDetailPage(category: data);
                            },
                          ),
                        );

                        if (updated is CategoryEntity) {
                          manager.updateCategory(updated, data);
                        }
                      }

                      if (selected == 'delete') {
                        var result = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _CategoryDeleteDialog();
                          },
                        );

                        if (result != null && result) {
                          manager.deleteCategory(data);
                          Navigator.of(context).pop();
                        }
                      }
                    }
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
