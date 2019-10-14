import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/shared/pickers/color_picker/circle_color.dart';

class ColorPicker extends StatefulWidget {
  ColorPicker({
    Key key,
    @required this.colors,
    @required this.onChanged,
  }): assert(colors != null),
      assert(onChanged != null),
      super(key: key);

  final List<Color> colors;
  final ValueChanged<Color> onChanged;

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  List<Color> colors;
  Color current;

  @override
  void initState() {
    super.initState();
    this.colors = this.widget.colors;
    this.current = this.colors[0];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Container> children = <Container>[];

    this.colors.forEach((Color color) {
      children.add(
        Container(
          child: CircleColor(
            color: color,
            selected: this.current == color,
            onTap: () {
              setState(() {
                this.current = color;
                this.widget.onChanged(color);
              });
            }
          ),
        )
      );
    });

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5)
        ),
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          crossAxisCount: 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: children,
        )
      ),
    );
  }
}
