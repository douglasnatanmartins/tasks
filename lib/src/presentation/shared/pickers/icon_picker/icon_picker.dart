import 'package:flutter/material.dart';

part 'icon_grid_view.dart';
part 'icon_grid_item.dart';

class IconPicker extends StatefulWidget {
  /// Create a IconPicker widget.
  /// 
  /// The [icons] and [onChanged] arguments must not be null.
  IconPicker({
    Key key,
    this.current,
    @required this.icons,
    @required this.onChanged,
  }): assert(icons != null),
      assert(onChanged != null),
      super(key: key);

  final List<IconData> icons;
  final IconData current;
  final ValueChanged<IconData> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  List<IconData> icons;
  IconData current;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.icons = this.widget.icons;
    if (this.icons.contains(this.widget.current)) {
      this.current = this.widget.current;
    } else {
      this.current = this.icons.elementAt(0);
    }
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(IconPicker old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the IconPicker widget with state.
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Icon(this.current, color: Colors.white),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return _IconGridView(
              value: this.current,
              items: this.icons,
              onChanged: (IconData icon) {
                setState(() {
                  this.current = icon;
                  this.widget.onChanged(this.current);
                });
              },
            );
          },
        );
      },
    );
  }
}
