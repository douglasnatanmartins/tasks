import 'package:flutter/material.dart';

class IconCheckbox extends StatefulWidget {
  /// Create a IconCheckbox widget.
  /// 
  /// The [value], [icon] and [onChanged] arguments must not be null.
  IconCheckbox({
    Key key,
    this.selectedColor,
    this.unselectedColor,
    @required this.value,
    @required this.icon,
    @required this.onChanged,
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
    this.value = this.widget.value;
    this.selectedColor = this.widget.selectedColor ?? Colors.yellow[700];
    this.unselectedColor = this.widget.unselectedColor ?? Colors.grey[400];
    this.onChangedColor(this.value);
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(IconCheckbox old) {
    if (this.value != this.widget.value) {
      this.value = this.widget.value;
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  void onChangedColor(bool checked) {
    this.color = checked ? this.selectedColor : this.unselectedColor;
  }

  /// Build the IconCheckbox widget with state.
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(this.widget.icon),
      color: this.color,
      onPressed: () {
        setState(() {
          this.value = !this.value;
          this.onChangedColor(this.value);
          this.widget.onChanged(this.value);
        });
      },
    );
  }
}
