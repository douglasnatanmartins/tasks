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
    children.add(const SizedBox(height: 10.0));
    children.add(
      Text(
        this.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: (this.textColor ?? Colors.black),
          fontSize: 19.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    // Has description.
    if (this.description != null) {
      children.add(const SizedBox(height: 5.0));
      children.add(
        Text(
          this.description,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: (this.textColor ?? Colors.black).withOpacity(0.65),
            fontSize: 15,
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
