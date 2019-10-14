import 'package:flutter/material.dart';

class EditableTitle extends StatefulWidget {
  EditableTitle({
    Key key,
    @required this.title,
    @required this.onChanged
  }): assert(title != null),
      assert(onChanged != null),
      super(key: key);

  final String title;
  final ValueChanged<String> onChanged;

  @override
  State<EditableTitle> createState() => _EditableTitleState();
}

class _EditableTitleState extends State<EditableTitle> {
  String title;
  FocusNode focusNode;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    this.title = this.widget.title;
    this.focusNode = FocusNode();
    this.controller = TextEditingController(text: this.title);

    this.focusNode.addListener(() {
      if (!this.focusNode.hasFocus) {
        String value = this.controller.text.trim();
        if (value.isEmpty) {
          this.controller.text = value;
        } else {
          if (value != this.title) {
            this.title = value;
            this.widget.onChanged(value);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    this.focusNode.dispose();
    this.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        focusNode: this.focusNode,
        controller: this.controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.25
            )
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue.withOpacity(0.85),
              width: 0.5
            )
          )
        ),
        style: TextStyle(
          color: Colors.blue.shade400,
          fontSize: 20.0,
          fontWeight: FontWeight.w600
        ),
        cursorColor: Colors.blue,
        onChanged: (String value) {
          this.widget.onChanged(value.trim());
        }
      )
    );
  }
}
