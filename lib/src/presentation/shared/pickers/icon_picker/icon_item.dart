import 'package:flutter/material.dart';

class IconItem extends StatelessWidget {
  /// Create a IconItem widget.
  /// 
  /// The [icon] and [onTap] arguments must not be null.
  IconItem({
    Key key,
    this.selected = false,
    @required this.icon,
    @required this.onTap,
  }): assert(icon != null),
      assert(onTap != null),
      super(key: key);

  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  /// Build the IconItem widget.
  @override
  Widget build(BuildContext context) {
    Color color = this.selected ? Colors.blue[400] : Colors.grey[400];

    return Center(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 3.0,
              color: color,
            ),
            color: Colors.white.withOpacity(0.25),
          ),
          child: Icon(
            this.icon,
            color: color,
          ),
        ),
        onTap: this.onTap,
      ),
    );
  }
}
