part of '../task_layout.dart';

class _StepListTile extends StatefulWidget {
  /// Create a _StepListTile widget.
  /// 
  /// The [data] and [onChanged] arguments must not be null.
  _StepListTile({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): assert(data != null),
      assert(onChanged != null),
      super(key: key);

  final StepEntity data;
  final ValueChanged<StepEntity> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<_StepListTile> createState() => _StepListTileState();
}

class _StepListTileState extends State<_StepListTile> {
  StepEntity data;
  TextEditingController messageController;
  TextEditingValue messageValue;
  FocusNode focusNode;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    data = widget.data;
    messageValue = TextEditingValue(text: data.message ?? '');
    messageController = TextEditingController.fromValue(messageValue);
    focusNode = FocusNode();

    // Add listener for focus node of message text field.
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        String value = messageController.value.text.trim();
        data = data.copyWith(
          message: value,
        );
        widget.onChanged(data);
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
  void didUpdateWidget(_StepListTile old) {
    if (old.data != widget.data) {
      data = widget.data;
    }

    if (data.id == null) {
      messageController.clear();
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    messageController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void markCompleted(bool checked) {
    setState(() {
      data = data.copyWith(isDone: checked);
      widget.onChanged(data);
    });
  }

  /// Build the _StepListTile widget with state.
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: data.isDone,
        onChanged: data.id != null ? markCompleted : null,
      ),
      title: TextField(
        autocorrect: false,
        controller: messageController,
        focusNode: focusNode,
        cursorColor: Colors.blue.withOpacity(0.85),
        decoration: InputDecoration(
          hintText: 'Enter step',
          hintStyle: TextStyle(
            color: Colors.blue.withOpacity(0.5),
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.5),
            ),
          ),
        ),
        style: TextStyle(
          color: Colors.black.withOpacity(0.85),
        ),
      ),
      trailing: data.id != null ? buildDeleteButton() : null,
    );
  }

  Widget buildDeleteButton() {
    return IconButton(
      icon: Icon(Icons.clear),
      color: Colors.red,
      onPressed: () {
        data = data.copyWith(message: '');
        widget.onChanged(data);
      },
    );
  }
}
