part of '../task_layout.dart';

class _TaskNoteTextField extends StatefulWidget {
  /// Create a _TaskNoteTextField widget.
  /// 
  /// The [onChanged] argument must not be null.
  _TaskNoteTextField({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): assert(onChanged != null),
      super(key: key);

  final String data;
  final ValueChanged<String> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<_TaskNoteTextField> createState() => _TaskNoteTextFieldState();
}

class _TaskNoteTextFieldState extends State<_TaskNoteTextField> {
  TextEditingController controller;
  FocusNode focusNode;
  
  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.data);
    focusNode = FocusNode();
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(_TaskNoteTextField old) {
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the _TaskNoteTextField widget with state.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(
        decoration: const InputDecoration.collapsed(
          hintText: 'Note',
          border: InputBorder.none,
        ),
        autocorrect: false,
        focusNode: focusNode,
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        onChanged: widget.onChanged,
      )
    );
  }
}
