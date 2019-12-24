import 'package:flutter/material.dart';

class IconCheckbox extends StatefulWidget {
  /// Create a IconCheckbox widget.
  /// 
  /// The [value], [icon] and [onChanged] arguments must not be null.
  IconCheckbox({
    Key key,
    @required this.value,
    @required this.icon,
    @required this.onChanged,
    this.selectedColor,
    this.unselectedColor,
  }): assert(value != null),
      assert(icon != null),
      assert(onChanged != null),
      super(key: key);

  final bool value;
  final Color selectedColor;
  final Color unselectedColor;
  final IconData icon;
  final ValueChanged<bool> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<IconCheckbox> createState() => _IconCheckboxState();
}

class _IconCheckboxState extends State<IconCheckbox> {
  bool value;
  Color color;
  Color selectedColor;
  Color unselectedColor;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    value = widget.value;
    selectedColor = widget.selectedColor ?? Colors.yellow[700];
    unselectedColor = widget.unselectedColor ?? Colors.grey[400];
    onChangedColor(value);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(IconCheckbox old) {
    if (old.value != widget.value) {
      value = widget.value;
      onChangedColor(value);
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  void onChangedColor(bool checked) {
    color = checked ? selectedColor : unselectedColor;
  }

  /// Build the IconCheckbox widget with state.
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.icon),
      color: color,
      onPressed: () {
        setState(() {
          value = !value;
          onChangedColor(value);
          widget.onChanged(value);
        });
      },
    );
  }
}
