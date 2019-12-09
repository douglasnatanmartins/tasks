part of '../project_detail_page.dart';

class _ActionButtons extends StatelessWidget {
  /// Create a ActionButtons widget.
  _ActionButtons({
    Key key,
    @required this.onSaved,
  })  : assert(onSaved != null),
        super(key: key);

  final VoidCallback onSaved;

  /// Build the ActionButtons widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(7.0),
            ),
            color: Colors.grey.shade400,
            textColor: Colors.white,
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          const SizedBox(width: 10.0),
          FlatButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: Colors.white),
              borderRadius: BorderRadius.circular(7.0),
            ),
            color: Colors.green.shade400,
            textColor: Colors.white,
            child: const Text('Save'),
            onPressed: this.onSaved,
          ),
        ],
      ),
    );
  }
}
