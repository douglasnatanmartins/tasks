import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';

part 'sections/bottom_bar.dart';
part 'sections/important_checkbox.dart';
part 'sections/page_body.dart';
part 'sections/page_footer.dart';
part 'sections/page_header.dart';
part 'sections/step_list_tile.dart';
part 'sections/step_list_view.dart';
part 'sections/task_delete_dialog.dart';
part 'sections/task_note_text_field.dart';
part 'sections/task_title_text_field.dart';

class TaskLayout extends StatelessWidget {
  /// Create a TaskLayout widget.
  TaskLayout({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): super(key: key);

  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

  /// Build the TaskLayout widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                _PageHeader(
                  data: data,
                  onChanged: onChanged,
                ),
                _PageBody(data: data),
                _PageFooter(
                  data: data,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: _BottomBar(data: data),
    );
  }
}
