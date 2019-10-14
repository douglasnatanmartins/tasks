import 'package:flutter/material.dart';

class CircleColor extends StatelessWidget {
  CircleColor({
    Key key,
    @required this.color,
    @required this.onTap,
    @required this.selected,
  }): assert(color != null),
      assert(onTap != null),
      super(key: key);

  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Border border;

    if (this.selected) {
      border = Border.all(
        color: this.color,
        width: 3.0
      );
    }

    return Center(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: this.onTap,
        child: AnimatedContainer(
          width: 32,
          height: 32,
          duration: const Duration(milliseconds: 210),
          padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: border
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: this.color
            )
          )
        )
      ),
    );
  }
}
