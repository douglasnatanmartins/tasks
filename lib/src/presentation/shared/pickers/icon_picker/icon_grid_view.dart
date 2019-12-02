part of 'icon_picker.dart';

class _IconGridView extends StatefulWidget {
  /// Create a _IconGridView widget.
  _IconGridView({
    Key key,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  }): super(key: key);

  final IconData value;
  final List<IconData> items;
  final ValueChanged<IconData> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<_IconGridView> createState() => _IconGridViewState();
}

class _IconGridViewState extends State<_IconGridView> {
  IconData current;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.current = this.widget.value;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(_IconGridView old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the _IconGridView widget with state.
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      crossAxisCount: 5,
      crossAxisSpacing: 20.0,
      mainAxisSpacing: 20.0,
      children: this.widget.items.map((IconData item) {
        return _IconGridItem(
          icon: item,
          selected: this.current == item,
          onTap: () {
            setState(() {
              this.current = item;
              this.widget.onChanged(this.current);
            });
          },
        );
      }).toList(),
    );
  }
}
