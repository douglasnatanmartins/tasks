part of '../project_detail_page.dart';

class _DescriptionTextField extends StatelessWidget {
  /// Create a _DescriptionTextField widget.
  /// 
  /// The [controller] arugment must not be null.
  _DescriptionTextField({
    Key key,
    @required this.controller,
  }): assert(controller != null),
      super(key: key);

  final TextEditingController controller;

  /// Build the _DescriptionTextField widget.
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      decoration: InputDecoration(
        hintText: 'Description',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
        counterStyle: TextStyle(color: Colors.white),
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      maxLength: 255,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 17.0,
      ),
    );
  }
}
