part of '../task_layout.dart';

class _StepListView extends StatelessWidget {
  /// Create a _StepListView widget.
  _StepListView({
    Key key,
    @required this.items,
  }): super(key: key);

  final List<StepEntity> items;

  /// Build the _StepListView widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TaskController>(context);
    List<_StepListTile> tiles = <_StepListTile>[];

    // Add exists steps.
    if (items != null) {
      for (var item in items) {
        tiles.add(buildItem(item, controller));
      }
    }

    tiles.add(
      buildItem(
        StepEntity(
          id: null,
          message: null,
          taskId: controller.task.id,
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
      onChanged: (value) {
        if (value.id == null) {
          if (value.message.isNotEmpty) {
            controller.createStep(value);
          }
        } else {
          if (value.message.isEmpty) {
            controller.deleteStep(item);
          } else {
            controller.updateStep(value, item);
          }
        }
      },
    );
  }
}
