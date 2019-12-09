part of '../task_layout.dart';

class _TaskTitleTextField extends StatefulWidget {
  /// Create a _TaskTitleTextField widget.
  _TaskTitleTextField({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): super(key: key);

  final String data;
  final ValueChanged<String> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<_TaskTitleTextField> createState() => _TaskTitleTextFieldState();
}

class _TaskTitleTextFieldState extends State<_TaskTitleTextField> {
  String data;
  FocusNode focusNode;
  TextEditingController controller;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
    this.focusNode = FocusNode();
    this.controller = TextEditingController(text: this.data);

    this.focusNode.addListener(() {
      if (!this.focusNode.hasFocus) {
        String value = this.controller.text.trim();
        if (value.isEmpty) {
          this.controller.text = this.widget.data;
          this.data = this.widget.data;
          this.widget.onChanged(this.widget.data);
        }
      }
    });
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(_TaskTitleTextField old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.focusNode.dispose();
    this.controller.dispose();
    super.dispose();
  }

  /// Build the TaskTitleTextField widget with state.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        focusNode: this.focusNode,
        controller: this.controller,
        decoration: InputDecoration.collapsed(
          hintText: 'Title',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        style: TextStyle(
          color: Colors.blue.shade400,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: Colors.blue,
        onChanged: (String value) {
          if (value.trim().isEmpty) {
            this.widget.onChanged(this.widget.data);
          } else {
            this.widget.onChanged(value.trim());
          }
        },
      ),
    );
  }
}
