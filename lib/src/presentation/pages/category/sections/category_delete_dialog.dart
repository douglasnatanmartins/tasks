part of '../category_layout.dart';

class _CategoryDeleteDialog extends StatelessWidget {
  /// Create a CategoryDeleteDialog widget.
  _CategoryDeleteDialog({
    Key key,
  }) : super(key: key);

  /// Build the CategoryDeleteDialog widget.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: const Text('Are you want delete this category?'),
      actions: <Widget>[
        // Cancel button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          color: Colors.grey[400],
          textColor: Colors.white,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        // Yes Button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          color: Theme.of(context).errorColor,
          textColor: Colors.white,
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
