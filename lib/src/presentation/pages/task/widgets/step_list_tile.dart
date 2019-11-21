import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/step_model.dart';

class StepListTile extends StatefulWidget {
  /// Create a StepListTile widget.
  /// 
  /// The [data] and [onChanged] arguments must not be null.
  StepListTile({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): assert(data != null),
      assert(onChanged != null),
      super(key: key);

  final StepModel data;
  final ValueChanged<StepModel> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<StepListTile> createState() => _StepListTileState();
}

class _StepListTileState extends State<StepListTile> {
  StepModel data;
  TextEditingController controller;
  TextEditingValue value;
  FocusNode focusNode;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
    this.value = TextEditingValue(text: this.data.title);
    this.controller = TextEditingController.fromValue(this.value);
    this.focusNode = FocusNode();

    this.focusNode.addListener(() {
      if (!this.focusNode.hasFocus) {
        String value = this.controller.value.text.trim();
        if (value.isNotEmpty) {
          this.data.title = value;
          this.widget.onChanged(this.data);
        } else {
          this.deleteStep();
        }
      }
    });

    this.controller.addListener(() {
      this.value = this.controller.value;
    });
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(StepListTile old) {
    if (old.data != this.widget.data) {
      this.data = this.widget.data;
    }

    if (this.data.id == null) {
      this.controller.value = this.value.copyWith(text: '');
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

  void updateStep(bool checked) {
    this.data.done = checked;
    this.widget.onChanged(this.data);
  }

  void deleteStep() {
    this.data.title = null;
    this.widget.onChanged(this.data);
  }

  /// Build the StepListTile widget with state.
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: this.data.done,
        onChanged: this.data.id != null ? this.updateStep : null,
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
      trailing: IconButton(
        icon: Icon(Icons.clear),
        color: Colors.red,
        onPressed: this.data.id != null ? this.deleteStep : null,
      ),
    );
  }
}
