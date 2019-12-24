import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/src/core/provider.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/presentation/controllers/step_manager_contract.dart';
import 'package:tasks/src/presentation/pages/task/task_controller.dart';
import 'package:tasks/src/presentation/shared/pickers/date_picker/date_picker.dart';
import 'package:tasks/src/presentation/shared/widgets/circle_checkbox.dart';
import 'package:tasks/src/presentation/shared/widgets/icon_checkbox.dart';

part 'sections/bottom_bar.dart';
part 'sections/page_body.dart';
part 'sections/page_footer.dart';
part 'sections/page_header.dart';
part 'sections/step_list_tile.dart';
part 'sections/step_list_view.dart';
part 'sections/task_delete_dialog.dart';
part 'sections/task_title_text_field.dart';

class TaskLayout extends StatelessWidget {
  /// Create a TaskLayout widget.
  TaskLayout({
    Key key,
  }): super(key: key);

  /// Build the TaskLayout widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TaskController>(context);

    return WillPopScope(
      onWillPop: () async {
        controller.updateTask();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  PageHeader(),
                  PageBody(),
                  PageFooter(),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
