part of '../task_layout.dart';

class _TaskDeleteDialog extends StatelessWidget {
  /// Create a _TaskDeleteDialog widget.
  _TaskDeleteDialog({
    Key key,
  }): super(key: key);

  /// Build the _TaskDeleteDialog widget.
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: const Text('Are you sure delete this task?'),
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
          onPressed: () { // When the user pressed CANCEL button.
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
          onPressed: () { // When the user pressed YES button.
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
