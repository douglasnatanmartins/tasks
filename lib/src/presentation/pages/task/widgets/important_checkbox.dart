part of '../task_page.dart';

class _ImportantCheckbox extends StatelessWidget {
  /// Create a _ImportantCheckbox widget.
  _ImportantCheckbox({
    Key key,
    @required this.value,
    @required this.onChanged,
  }): super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  /// Build the _ImportantCheckbox widget.
  @override
  Widget build(BuildContext context) {
    return IconCheckbox(
      value: this.value,
      icon: Icons.star,
      onChanged: this.onChanged,
    );
  }
}
