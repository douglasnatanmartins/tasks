import 'package:flutter/material.dart';

class NoteTextField extends StatefulWidget {
  const NoteTextField({
    Key key,
    @required this.note,
    @required this.onChanged
  }): assert(onChanged != null),
      super(key: key);

  final String note;
  final ValueChanged<String> onChanged;
  
  @override
  State<NoteTextField> createState() => _NoteTextFieldState();
}

class _NoteTextFieldState extends State<NoteTextField> {
  TextEditingController controller;
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    this.controller = TextEditingController(text: this.widget.note);
    this.focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(NoteTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.2),
        //     blurRadius: 3.0,
        //     offset: const Offset(0.5, 4)
        //   )
        // ]
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        decoration: const InputDecoration.collapsed(
          hintText: 'Note',
          border: InputBorder.none
        ),
        autocorrect: false,
        focusNode: this.focusNode,
        controller: this.controller,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        onChanged: this.widget.onChanged
      )
    );
  }
}
