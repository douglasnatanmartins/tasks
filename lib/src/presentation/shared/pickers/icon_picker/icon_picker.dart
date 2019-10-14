import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/shared/pickers/icon_picker/icon_item.dart';

class IconPicker extends StatefulWidget {
  final List<IconData> icons;
  final IconData current;
  final ValueChanged<IconData> onChanged;

  IconPicker({
    Key key,
    @required this.icons,
    @required this.onChanged,
    @required this.current,
  }): assert(icons != null),
      assert(icons.length >= 1),
      assert(current != null),
      assert(onChanged != null),
      super(key: key);

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  IconData current;

  @override
  void initState() {
    super.initState();
    this.current = this.widget.current;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[];

    this.widget.icons.forEach((IconData data) {
      children.add(this.buildItem(data));
    });

    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      crossAxisCount: 5,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      children: children
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
