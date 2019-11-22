import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/utils/date_time_util.dart';

class DatePicker extends StatefulWidget {
  /// Create a DatePicker widget.
  /// 
  /// The [onChanged] arugment must not be null.
  DatePicker({
    Key key,
    this.icon,
    this.title,
    this.initialDate,
    @required this.onChanged,
  }): assert(onChanged != null),
      super(key: key);

  final IconData icon;
  final String title;
  final DateTime initialDate;
  final ValueChanged<DateTime> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime today;

  /// The date is current selected.
  DateTime current;

  String title;

  Color textColor;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.today = DateTimeUtil.onlyDate(DateTime.now());
    this.current = this.widget.initialDate;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(DatePicker old) {
    if (old.initialDate != this.widget.initialDate) {
      this.current = this.widget.initialDate;
    }
    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Set title, text color when changing the selected date.
  void onCurrentChanged() {
    if (this.current != null) {
      this.title = DateFormat.yMMMd().format(this.current);
      this.textColor = DateTimeUtil.difference(this.current).inDays >= 0
                       ? Colors.blue
                       : Colors.red;
    } else {
      this.title = this.widget.title ?? 'No date selected';
      this.textColor = Colors.grey;
    }
  }

  /// Build the DatePicker widget with state.
  @override
  Widget build(BuildContext context) {
    this.onCurrentChanged();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        leading: this.widget.icon != null ? Icon(this.widget.icon) : null,
        title: InkWell(
          child: Text(
            this.title,
            style: TextStyle(
              color: textColor,
            ),
          ),
          onTap: () async {
            // If not has given the initial date,
            // using today for replace to initial date.
            final date = this.current ?? this.today;
            DateTime result = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(date.year - 10),
              lastDate: DateTime(date.year + 10),
            );

            // If the user has selected date.
            if (result != null) {
              result = DateTimeUtil.onlyDate(result);
              setState(() {
                this.current = result;
                this.widget.onChanged(result);
              });
            }
          },
        ),
        trailing: this.current != null ? this._buildDeleteButton() : null,
      ),
    );
  }

  /// Build the delete button.
  Widget _buildDeleteButton() {
    return IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        setState(() {
          this.current = null;
          this.widget.onChanged(this.current);
        });
      },
    );
  }
}
