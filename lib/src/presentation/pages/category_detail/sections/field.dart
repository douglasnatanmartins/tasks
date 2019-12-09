part of '../category_detail_page.dart';

class _Field extends StatelessWidget {
  /// Create a _Field widget.
  _Field({
    Key key,
    @required this.label,
    @required this.controller,
  }): super(key: key);

  final String label;
  final TextEditingController controller;

  /// Build the _Field widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
          labelText: this.label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
