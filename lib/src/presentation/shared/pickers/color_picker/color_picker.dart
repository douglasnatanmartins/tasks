import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/shared/pickers/color_picker/circle_color.dart';

class ColorPicker extends StatefulWidget {
  final List<Color> colors;
  final ValueChanged<Color> onChanged;

  ColorPicker({
    Key key,
    @required this.colors,
    @required this.onChanged,
  }): assert(colors != null),
      assert(onChanged != null),
      super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color current;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = this.widget.colors;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 10.0);
          },
          itemBuilder: (BuildContext context, int index) {
            final color = colors[index];
            return CircleColor(
              color: color,
              selected: this.current == color,
              onTap: () {
                setState(() {
                  this.current = color;
                  this.widget.onChanged(color);
                });
              }
            );
          }
        ),
      ),
    );
  }
}
