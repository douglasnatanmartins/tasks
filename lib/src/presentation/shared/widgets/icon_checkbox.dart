import 'package:flutter/material.dart';

class IconCheckbox extends StatefulWidget {
  IconCheckbox({
    this.selectedColor,
    this.unselectedColor,
    @required this.icon,
    @required this.value,
    @required this.onChanged,
  });

  final bool value;
  final Color selectedColor;
  final Color unselectedColor;
  final IconData icon;
  final ValueChanged<bool> onChanged;

  @override
  State<IconCheckbox> createState() => _IconCheckboxState();
}

class _IconCheckboxState extends State<IconCheckbox> {
  bool value;
  Color color;
  Color selectedColor;
  Color unselectedColor;

  @override
  void initState() {
    super.initState();
    this.selectedColor = this.widget.selectedColor ?? Colors.yellow[700];
    this.unselectedColor = this.widget.unselectedColor ?? Colors.grey[400];
    this.value = this.widget.value;
    this.changeColor(this.value);
  }

  @override
  void didUpdateWidget(IconCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeColor(bool selected) {
    this.color = selected ? this.selectedColor : this.unselectedColor;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(this.widget.icon),
      color: this.color,
      onPressed: () {
        setState(() {
          this.value = !this.value;
          this.changeColor(this.value);
          this.widget.onChanged(this.value);
        });
      }
    );
  }
}
