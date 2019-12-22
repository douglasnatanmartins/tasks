part of '../category_layout.dart';

class CategoryDeleteDialog extends StatelessWidget {
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
          color: Colors.grey[400],
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('Cancel'),
        ),
        // Yes Button.
        FlatButton(
          color: Theme.of(context).errorColor,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
