part of '../task_page.dart';

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
    final component = Component.of<TaskController>(context);
    return Expanded(
      child: StreamBuilder(
        stream: component.steps,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _StepListView(
            taskId: data.id,
            items: snapshot.data,
          );
        },
      ),
    );
  }
}
