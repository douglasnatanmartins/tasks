part of '../task_page.dart';

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
  TextEditingController controller;
  TextEditingValue value;
  FocusNode focusNode;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
    this.value = TextEditingValue(text: this.data.message ?? '');
    this.controller = TextEditingController.fromValue(this.value);
    this.focusNode = FocusNode();

    // Add listener for focus node of message text field.
    this.focusNode.addListener(() {
      if (!this.focusNode.hasFocus) {
        String value = this.controller.value.text.trim();
        this.data = this.data.copyWith(
          message: value,
        );
        this.widget.onChanged(this.data);
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
    if (old.data != this.widget.data) {
      this.data = this.widget.data;
    }

    if (this.data.id == null) {
      this.controller.clear();
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    this.controller.dispose();
    this.focusNode.dispose();
    super.dispose();
  }

  void markCompleted(bool checked) {
    setState(() {
      this.data = this.data.copyWith(isDone: checked);
      this.widget.onChanged(this.data);
    });
  }

  /// Build the _StepListTile widget with state.
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: this.data.isDone,
        onChanged: this.data.id != null ? this.markCompleted : null,
      ),
      title: TextField(
        autocorrect: false,
        controller: this.controller,
        focusNode: this.focusNode,
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
      trailing: this.data.id != null ? this.buildDeleteButton() : null,
    );
  }

  Widget buildDeleteButton() {
    return IconButton(
      icon: Icon(Icons.clear),
      color: Colors.red,
      onPressed: () {
        this.data = this.data.copyWith(message: '');
        this.widget.onChanged(this.data);
      },
    );
  }
}
