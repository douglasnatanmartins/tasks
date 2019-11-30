import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class StepEntity implements Entity<StepEntity> {
  /// Create a step entity.
  /// 
  /// The [taskId] and [isDone] arguments must not be null.
  StepEntity({
    @required this.id,
    @required this.taskId,
    @required this.message,
    @required this.isDone,
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
    return '[Step Id: ${this.id}] - task id: ${this.taskId}, message: ${this.message}, isDone: ${this.isDone}.';
  }

  @override
  bool operator == (object) {
    return identical(object, this)
        || object is StepEntity
        && object.id == this.id
        && object.taskId == this.taskId
        && object.message == this.message
        && object.isDone == this.isDone;
  }

  @override
  int get hashCode {
    return this.id.hashCode
         ^ this.taskId.hashCode
         ^ this.message.hashCode
         ^ this.isDone.hashCode;
  }
}
