import 'package:flutter/material.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';
import 'package:tasks/src/domain/entities/task_entity.dart';
import 'package:tasks/src/presentation/screen/task_detail/task_detail_screen_bloc.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskEntity task;

  TaskDetailScreen({Key key, @required this.task}):
    assert(task != null),
    super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailScreenState();
  }
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  TaskDetailScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TaskDetailScreenBloc(task: widget.task);
  }
  @override
  Widget build(BuildContext context) {
    return _buildUI(context);
  }

  Widget _buildUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title)
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                initialData: widget.task.steps,
                stream: _bloc.streamOfSteps,
                builder: (context, snapshot) {
                  return _buildEditableListView(snapshot.data);
                }
              )
            )
          ]
        )
      )
    );
  }

  _buildEditableListView(List<StepEntity> steps) {
    List<ListTile> tiles = [];
    if (steps.length == 0) {
      steps.add(StepEntity(title: ''));
    }

    steps.asMap().forEach((index, step) {
      tiles.add(_buildRow(index, step, steps.length));
    });

    return ListView(
      children: tiles,
    );
  }

  _buildRow(int index, StepEntity step, int lengthSteps) {
    TextEditingController _controller = TextEditingController(
      text: step.title
    );

    return ListTile(
      leading: Checkbox(
        value: step.done,
        onChanged: (checked) {
          if (_controller.text.trim() != '') {
            _bloc.markStepIsDone(index, checked);
          }
        }
      ),
      title: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: "Enter step"
        ),
        onSubmitted: (text) {
          step.title = text;
          if (index == (lengthSteps - 1)) {
            _bloc.updateStep(index, step);
            _bloc.addStep(StepEntity(title: ''));
          } else {
            _bloc.updateStep(index, step);
          }
        }
      )
    );
  }
}
