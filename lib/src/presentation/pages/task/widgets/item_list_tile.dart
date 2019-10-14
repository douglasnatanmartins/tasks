import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/step_model.dart';

class ItemListTile extends StatefulWidget {
  final StepModel step;
  final ValueChanged<StepModel> onChanged;

  ItemListTile({
    Key key,
    this.step,
    this.onChanged
  }): assert(step != null),
      assert(onChanged != null),
      super(key: key);

  @override
  State<StatefulWidget> createState() => _ItemListTileState();
}

class _ItemListTileState extends State<ItemListTile> {
  StepModel step;
  TextEditingController controller;
  TextEditingValue value;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    this.step = this.widget.step;
    this.value = TextEditingValue(text: this.step.title);
    this.controller = TextEditingController.fromValue(this.value);
    this.focusNode = FocusNode();

    this.focusNode.addListener(() {
      if (!this.focusNode.hasFocus) {
        String value = this.controller.value.text.trim();
        if (value.isNotEmpty) {
          this.step.title = value;
          this.widget.onChanged(this.step);
        } else {
          this.deleteStep();
        }
      }
    });

    this.controller.addListener(() {
      this.value = this.controller.value;
    });
  }

  @override
  void didUpdateWidget(ItemListTile oldWidget) {
    if (oldWidget.step != this.widget.step) {
      this.step = this.widget.step;
    }

    if (this.step.id == null) {
      this.controller.value = this.value.copyWith(text: '');
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    this.controller.dispose();
    this.focusNode.dispose();
    super.dispose();
  }

  void updateStep(bool checked) {
    this.step.done = checked;
    this.widget.onChanged(this.step);
  }

  void deleteStep() {
    this.step.title = null;
    this.widget.onChanged(this.step);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: step.done,
        onChanged: this.step.id != null ? this.updateStep : null
      ),
      title: TextField(
        autocorrect: false,
        controller: this.controller,
        focusNode: this.focusNode,
        cursorColor: Colors.blue.withOpacity(0.85),
        decoration: InputDecoration(
          hintText: "Enter step",
          hintStyle: TextStyle(
            color: Colors.blue.withOpacity(0.5)
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.5)
            )
          )
        ),
        style: TextStyle(
          color: Colors.black.withOpacity(0.85)
        )
      ),
      trailing: IconButton(
        icon: Icon(Icons.clear),
        color: Colors.red,
        onPressed: this.step.id != null ? this.deleteStep : null
      ),
    );
  }
}
