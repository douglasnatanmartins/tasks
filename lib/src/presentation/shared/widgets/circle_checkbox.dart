import 'package:flutter/material.dart';

class CircleCheckbox extends StatefulWidget {
  /// Create a CircleCheckbox widget.
  /// 
  /// The [value] and [onChanged] arguments must not be null.
  CircleCheckbox({
    Key key,
    @required this.value,
    @required this.onChanged,
  }): assert(value != null),
      assert(onChanged != null),
      super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<CircleCheckbox> createState() => _CircleCheckboxState();
}

class _CircleCheckboxState extends State<CircleCheckbox> {
  bool value;
  Icon icon;
  Border border;
  Color background;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(CircleCheckbox old) {
    if (value != widget.value) {
      value = widget.value;
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the CircleCheckbox widget with state.
  @override
  Widget build(BuildContext context) {
    if (!value) {
      background = Colors.white.withOpacity(0.25);
      border = Border.all(width: 1.25, color: Colors.black.withOpacity(0.5));
      icon = null;
    } else {
      background = Colors.blue.shade200;
      border = null;
      icon = Icon(Icons.check, color: Colors.white, size: 20);
    }

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          this.value = !this.value;
          this.widget.onChanged(this.value);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 123),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 27,
        width: 27,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: border,
        ),
        child: this.icon,
      ),
    );
  }
}
