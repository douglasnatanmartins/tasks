import 'package:flutter/material.dart';

class EmptyContentBox extends StatelessWidget {
  /// Create a EmptyContentBox widget.
  /// 
  /// The [title] argument must not be null and not is empty string.
  EmptyContentBox({
    Key key,
    this.description,
    this.textColor,
    @required this.title,
  }): assert(title != null),
      assert(title.isNotEmpty),
      super(key: key);

  final String title;
  final String description;
  final Color textColor;

  /// Build the EmptyContentBox widget.
  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[];
    children.add(Image.asset('lib/assets/images/character.png'));
    children.add(const SizedBox(height: 15.0));
    children.add(
      Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: (textColor ?? Colors.black87),
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    // Has description.
    if (description != null) {
      children.add(const SizedBox(height: 5));
      children.add(
        Text(
          description,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: (textColor ?? Colors.black87).withOpacity(0.65),
            fontSize: 14,
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
