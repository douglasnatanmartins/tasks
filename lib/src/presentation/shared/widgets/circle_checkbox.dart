import 'package:flutter/material.dart';

class CircleCheckbox extends StatefulWidget {
  CircleCheckbox({
    Key key,
    @required this.value,
    @required this.onChanged
  }): assert(value != null),
      assert(onChanged != null),
      super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<CircleCheckbox> createState() => _CircleCheckboxState();
}

class _CircleCheckboxState extends State<CircleCheckbox> {
  bool value;
  Icon icon;
  Border border;
  Color background;

  @override
  void initState() {
    super.initState();
    this.value = this.widget.value;
  }

  @override
  void didUpdateWidget(CircleCheckbox oldWidget) {
    this.value = this.widget.value;
    super.didUpdateWidget(oldWidget);
  }

  /// Build circle checkbox.
  @override
  Widget build(BuildContext context) {
    if (!this.value) {
      background = Colors.white.withOpacity(0.25);
      border = Border.all(width: 1.25, color: Colors.black.withOpacity(0.5));
      icon = null;
    } else {
      border = null;
      background = Colors.blue.shade200;
      icon = Icon(Icons.check, color: Colors.white, size: 20.0);
    }

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 123),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: this.background,
          shape: BoxShape.circle,
          border: this.border,
        ),
        child: this.icon,
      ),
      onTap: () {
        setState(() {
          this.value = !this.value;
          this.widget.onChanged(this.value);
        });
      },
    );
  }
}
