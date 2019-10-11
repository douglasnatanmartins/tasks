import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final IconData icon;
  final String title;
  final ValueChanged<DateTime> onSelected;
  final DateTime initialDate;

  DatePicker({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.onSelected,
    @required this.initialDate
  }): assert(icon != null),
      assert(title != null),
      assert(onSelected != null),
      super(key: key);

  @override
  State<StatefulWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selected;
  String title;
  Color textColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.selected = this.widget.initialDate;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    Widget deleteButton;

    if (this.selected != null) {
      this.title = DateFormat.yMMMd().format(this.selected);
      deleteButton = this.trailing();
      if (today.difference(this.selected).inDays <= 0) {
        this.textColor = Colors.blue;
      } else {
        this.textColor = Colors.red;
      }
    } else {
      this.selected = today;
      this.title = this.widget.title;
      this.textColor = Colors.grey;
    }

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
            offset: const Offset(0.5, 4)
          )
        ]
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        leading: Icon(this.widget.icon),
        title: InkWell(
          child: Text(
            this.title,
            style: TextStyle(
              color: textColor
            )
          ),
          onTap: () async {
            DateTime result = await showDatePicker(
              context: this.context,
              initialDate: this.selected,
              firstDate: DateTime(this.selected.year - 10),
              lastDate: DateTime(today.year + 10)
            );

            if (result != null) {
              result = DateTime(result.year, result.month, result.day);
              setState(() {
                this.selected = result;
                this.widget.onSelected(result);
              });
            }
          }
        ),
        trailing: deleteButton
      )
    );
  }

  Widget trailing() {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        setState(() {
          this.selected = null;
          this.widget.onSelected(null);
        });
      }
    );
  }
}
