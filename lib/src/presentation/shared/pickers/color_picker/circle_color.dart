import 'package:flutter/material.dart';

class CircleColor extends StatelessWidget {
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  CircleColor({
    Key key,
    @required this.color,
    @required this.onTap,
    @required this.selected,
  }): assert(color != null),
      assert(onTap != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Material(
        child: CircleAvatar(
          backgroundColor: this.color,
          child: this.selected ? Icon(Icons.check, color: Colors.white.withOpacity(0.5)) : null
        )
      )
    );
  }
}
