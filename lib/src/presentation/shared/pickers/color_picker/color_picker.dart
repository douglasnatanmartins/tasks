import 'package:flutter/material.dart';

part 'color_grid_item.dart';

class ColorPicker extends StatefulWidget {
  /// Create a ColorPicker widget.
  /// 
  /// The [colors] and [onChanged] arguments must not be null.
  ColorPicker({
    Key key,
    this.current,
    @required this.colors,
    @required this.onChanged,
  }): assert(colors != null),
      assert(onChanged != null),
      super(key: key);
  
  final Color current;
  final List<Color> colors;
  final ValueChanged<Color> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  List<Color> colors;
  Color current;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    colors = widget.colors;

    if (colors.contains(widget.current)) {
      current = widget.current;
    } else {
      current = colors.elementAt(0);
    }
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(ColorPicker old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the ColorPicker widget with state.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
      ),
      child: GridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        crossAxisCount: 5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: widget.colors.map((Color color) {
          return _ColorGridItem(
            color: color,
            isChecked: current == color,
            onTap: () {
              setState(() {
                current = color;
                widget.onChanged(color);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
