part of '../category_layout.dart';

class _CategoryDeleteDialog extends StatelessWidget {
  /// Create a _CategoryDeleteDialog widget.
  _CategoryDeleteDialog({
    Key key,
  }) : super(key: key);

  /// Build the CategoryDeleteDialog widget.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: const Text('Are you want delete this category?'),
      actions: <Widget>[
        // Cancel button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0)),
          color: Colors.grey[400],
          textColor: Colors.white,
          child: const Text('Cancel'),
          onPressed: () {
            // When the user pressed CANCEL button.
            Navigator.of(context).pop(false);
          },
        ),
        // Yes Button.
        FlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          color: Theme.of(context).errorColor,
          textColor: Colors.white,
          child: const Text('Yes'),
          onPressed: () {
            // When the user pressed YES button.
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
