import 'package:flutter/material.dart';

class TaskNoteTextField extends StatefulWidget {
  /// Create a TaskNoteTextField widget.
  /// 
  /// The [onChanged] argument must not be null.
  TaskNoteTextField({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): assert(onChanged != null),
      super(key: key);

  final String data;
  final ValueChanged<String> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<TaskNoteTextField> createState() => _TaskNoteTextFieldState();
}

class _TaskNoteTextFieldState extends State<TaskNoteTextField> {
  TextEditingController controller;
  FocusNode focusNode;
  
  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.controller = TextEditingController(text: this.widget.data);
    this.focusNode = FocusNode();
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(TaskNoteTextField old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the TaskNoteTextField widget with state.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        decoration: const InputDecoration.collapsed(
          hintText: 'Note',
          border: InputBorder.none,
        ),
        autocorrect: false,
        focusNode: this.focusNode,
        controller: this.controller,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        onChanged: this.widget.onChanged,
      )
    );
  }
}
