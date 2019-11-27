import 'package:flutter/material.dart';
import 'package:tasks/src/data/models/task_model.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

import 'important_checkbox.dart';
import 'task_title_text_field.dart';

class PageHeader extends StatelessWidget {
  /// Create a PageHeader widget.
  PageHeader({
    Key key,
    @required this.model,
    this.onChanged,
  }): super(key: key);

  final TaskModel model;
  final ValueChanged<TaskModel> onChanged;

  /// Build the PageHeader widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Back previous screen button.
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: const EdgeInsets.all(10.0),
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back),
              color: Colors.grey[400],
              textColor: Colors.black.withOpacity(0.75),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TaskTitleTextField(
                    data: this.model.title,
                    onChanged: (String title) {
                      this.model.title = title;
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                CircleCheckbox(
                  value: this.model.done,
                  onChanged: (bool checked) {
                    this.model.done = checked;
                  },
                ),
                ImportantCheckBox(
                  value: this.model.important,
                  onChanged: (bool checked) {
                    this.model.important = checked;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
