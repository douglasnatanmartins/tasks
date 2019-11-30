import 'package:meta/meta.dart';
import 'package:tasks/src/domain/entities/step_entity.dart';

class StepModel extends StepEntity {
  StepModel({
    int id,
    @required int taskId,
    @required String message,
    @required bool isDone,
  }): super(
    id: id,
    taskId: taskId,
    message: message,
    isDone: isDone,
  );

  factory StepModel.from(Map<String, dynamic> object) {
    return StepModel(
      id: object['id'],
      taskId: object['task_id'],
      message: object['message'],
      isDone: object['is_done'] == 1 ? true : false,
    );
  }
}
