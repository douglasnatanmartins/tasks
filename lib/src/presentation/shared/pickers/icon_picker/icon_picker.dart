import 'package:flutter/material.dart';
import 'icon_item.dart';

class IconPicker extends StatefulWidget {
  /// Create a IconPicker widget.
  IconPicker({
    Key key,
    this.current,
    @required this.icons,
    @required this.onChanged,
  }): assert(icons != null),
      assert(icons.length > 0),
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
    if (this.icons != this.widget.icons) {
      this.icons = this.widget.icons;
      if (this.icons.contains(this.widget.current)) {
        this.current = this.widget.current;
      } else {
        this.current = this.icons.elementAt(0);
      }
    }

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
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      crossAxisCount: 5,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      children: this.icons.map((IconData item) {
        return this.buildItem(item);
      }).toList(),
    );
  }

  Widget buildItem(IconData data) {
    return IconItem(
      icon: data,
      selected: this.current == data,
      onTap: () {
        setState(() {
          this.current = data;
          this.widget.onChanged(this.current);
        });
      },
    );
  }
}
