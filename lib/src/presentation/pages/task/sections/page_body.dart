part of '../task_layout.dart';

class PageBody extends StatelessWidget {
  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TaskController>(context);

    return StreamBuilder<List<StepEntity>>(
      initialData: controller.steps,
      stream: controller.stepListStream,
      builder: (context, snapshot) {
        return _StepListView(
          items: snapshot.data,
        );
      },
    );
  }
}
