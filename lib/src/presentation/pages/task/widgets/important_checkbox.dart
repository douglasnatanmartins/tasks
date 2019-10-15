import 'package:flutter/material.dart';

class ImportantCheckBox extends StatefulWidget {
  ImportantCheckBox({
    Key key,
    @required this.value,
    @required this.onChanged
  }): assert(value != null),
      assert(onChanged != null),
      super(key: key);

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<ImportantCheckBox> createState() => _ImportantCheckboxState();
}

class _ImportantCheckboxState extends State<ImportantCheckBox> {
  bool value;

  @override
  void initState() {
    super.initState();
    this.value = this.widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.15)
        ),
        duration: Duration(milliseconds: 150),
        padding: const EdgeInsets.all(10),
        child: Icon(
          Icons.star,
          color: this.value ? Colors.yellow[700] : Colors.black.withOpacity(0.5),
          size: 24
        )
      ),
      onTap: () {
        setState(() {
          this.value = !this.value;
          this.widget.onChanged(this.value);
        });
      },
    );
  }
}
