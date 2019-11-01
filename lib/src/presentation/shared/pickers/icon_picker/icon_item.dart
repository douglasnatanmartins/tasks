import 'package:flutter/material.dart';

class IconItem extends StatelessWidget {
  IconItem({
    Key key,
    @required this.icon,
    @required this.selected,
    @required this.onTap
  }): assert(icon != null),
      assert(selected != null),
      assert(onTap != null),
      super(key: key);

  final IconData icon;
  final Function onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey[400];

    if (this.selected) {
      color = Colors.blue[400];
    }

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
