part of '../task_layout.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
    @required this.data,
  }): super(key: key);

  final TaskEntity data;

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TaskController>(context);

    return Expanded(
      child: StreamBuilder(
        stream: controller.steps,
        builder: (context, snapshot) {
          return _StepListView(
            taskId: data.id,
            items: snapshot.data,
          );
        },
      ),
    );
  }
}
