part of '../task_layout.dart';

class _StepListView extends StatelessWidget {
  /// Create a _StepListView widget.
  _StepListView({
    Key key,
    @required this.taskId,
    @required this.items,
  }): super(key: key);

  final List<StepEntity> items;
  final int taskId;

  /// Build the _StepListView widget.
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TaskController>(context);
    List<_StepListTile> tiles = <_StepListTile>[];

    // Add exists steps.
    if (this.items != null) {
      for (var item in this.items) {
        tiles.add(this.buildItem(item, controller));
      }
    }

    tiles.add(
      this.buildItem(
        StepEntity(
          id: null,
          message: null,
          taskId: this.taskId,
          isDone: false,
        ),
        controller,
      )
    );

    return Container(
      child: Column(
        children: tiles,
      ),
    );
  }

  Widget buildItem(StepEntity item, StepManagerContract controller) {
    return _StepListTile(
      key: Key(item.id.toString()),
      data: item,
      onChanged: (StepEntity step) {
        if (step.id == null) {
          if (step.message.isNotEmpty) {
            controller.addStep(step);
          }
        } else {
          if (step.message.isEmpty) {
            controller.deleteStep(item);
          } else {
            controller.updateStep(item, step);
          }
        }
      },
    );
  }
}
