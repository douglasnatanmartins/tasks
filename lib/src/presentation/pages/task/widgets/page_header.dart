import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';

import 'important_checkbox.dart';
import 'task_title_text_field.dart';

class PageHeader extends StatelessWidget {
  /// Create a PageHeader widget.
  PageHeader({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): super(key: key);

  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

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
                    data: this.data.title,
                    onChanged: (String title) {
                      this.onChanged(this.data.copyWith(
                        title: title,
                      ));
                    },
                  ),
                ),
                const SizedBox(width: 10.0),
                CircleCheckbox(
                  value: this.data.isDone,
                  onChanged: (bool checked) {
                    this.onChanged(this.data.copyWith(
                      isDone: checked,
                    ));
                  },
                ),
                ImportantCheckBox(
                  value: this.data.isImportant,
                  onChanged: (bool checked) {
                    this.onChanged(this.data.copyWith(
                      isImportant: checked,
                    ));
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
