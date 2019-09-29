import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final String note;
  final ValueChanged<String> onChanged;

  NoteFormWidget({
    Key key,
    @required this.note,
    @required this.onChanged
  }): assert(onChanged != null),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = note;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black.withOpacity(0.2)
        ),
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 3.0,
            offset: Offset(0.5, 4)
          )
        ]
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'Note',
          border: InputBorder.none
        ),
        controller: this.controller,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        onChanged: (String value) {
          this.onChanged(value);
        }
      )
    );
  }
}
