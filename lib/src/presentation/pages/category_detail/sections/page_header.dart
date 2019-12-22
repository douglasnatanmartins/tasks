part of '../category_detail_page.dart';

class _PageHeader extends StatelessWidget {
  /// Create a Page Header widget.
  _PageHeader({
    Key key,
  }): super(key: key);

  /// Build the Page Header widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
          const Spacer(flex: 1),
          Consumer<_Shared>(
            builder: (context, shared) {
              return Hero(
                tag: 'floating-button',
                child: FlatButton(
                  padding: const EdgeInsets.all(10.0),
                  shape: const CircleBorder(),
                  color: Colors.green[400],
                  child: const Icon(Icons.save, color: Colors.white),
                  onPressed: () {
                    String title = shared.titleController.text.trim();
                    if (title.isEmpty) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Title not empty')),
                      );
                    } else {
                      var description = shared.descriptionController.text.trim();
                      CategoryEntity category = shared.data.copyWith(
                        title: title,
                        description: description.isNotEmpty ? description : null,
                      );
                      Navigator.of(context).pop(category);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
