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
    this.value = this.widget.value;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(CircleCheckbox old) {
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

  /// Build the CircleCheckbox widget with state.
  @override
  Widget build(BuildContext context) {
    if (!this.value) {
      this.background = Colors.white.withOpacity(0.25);
      this.border = Border.all(width: 1.25, color: Colors.black.withOpacity(0.5));
      this.icon = null;
    } else {
      this.background = Colors.blue.shade200;
      this.border = null;
      this.icon = Icon(Icons.check, color: Colors.white, size: 20.0);
    }

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 123),
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        height: 27.0,
        width: 27.0,
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
