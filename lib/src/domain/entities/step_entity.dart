import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class StepEntity implements Entity<StepEntity> {
  /// Create a step entity.
  /// 
  /// The [taskId] and [isDone] arguments must not be null.
  StepEntity({
    this.id,
    @required this.taskId,
    @required this.isDone,
    this.message,
  }): assert(taskId != null),
      assert(isDone != null);

  final int id;
  final int taskId;
  final String message;
  final bool isDone;

  @override
  StepEntity copyWith({
    String message,
    bool isDone,
  }) {
    return StepEntity(
      id: this.id,
      taskId: this.taskId,
      message: message ?? this.message,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return '[Step Id: $id]: '
    'task_id: $taskId, '
    'message: $message, '
    'isDone: $isDone.';
  }

  @override
  bool operator == (object) {
    return identical(object, this)
        || object is StepEntity
        && object.id == id
        && object.taskId == taskId
        && object.message == message
        && object.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode
         ^ taskId.hashCode
         ^ message.hashCode
         ^ isDone.hashCode;
  }
}
