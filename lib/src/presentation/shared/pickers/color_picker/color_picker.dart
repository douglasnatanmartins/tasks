import 'package:flutter/material.dart';

part 'color_grid_item.dart';

class ColorPicker extends StatefulWidget {
  /// Create a ColorPicker widget.
  ColorPicker({
    Key key,
    this.current,
    @required this.colors,
    @required this.onChanged,
  }): assert(colors != null),
      assert(onChanged != null),
      super(key: key);

  final List<Color> colors;
  final Color current;
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
    this.colors = this.widget.colors;

    if (this.colors.indexOf(this.widget.current) >= 0) {
      this.current = this.widget.current;
    } else {
      this.current = this.colors.elementAt(0);
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        crossAxisCount: 5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: this.widget.colors.map((Color color) {
          return _ColorGridItem(
            color: color,
            isChecked: this.current == color,
            onTap: () {
              setState(() {
                this.current = color;
                this.widget.onChanged(color);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}
