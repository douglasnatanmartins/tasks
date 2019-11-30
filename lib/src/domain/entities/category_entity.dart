import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class CategoryEntity implements Entity<CategoryEntity> {
  /// Create a category entity.
  /// 
  /// The [title] and [createdDate] arguments must not be null.
  CategoryEntity({
    this.id,
    @required this.title,
    @required this.description,
    @required this.createdDate,
  }): assert(title != null),
      assert(createdDate != null);

  final int id;
  final String title;
  final String description;
  final DateTime createdDate;

  @override
  CategoryEntity copyWith({
    String title,
    String description,
  }) {
    return CategoryEntity(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: this.createdDate,
    );
  }

  @override
  String toString() {
    return '[Category ID ${this.id}]: ${this.title}, ${this.description}, ${this.createdDate}.';
  }

  @override
  bool operator == (object) {
    return identical(this, object)
        || object is CategoryEntity
        && object.id == this.id
        && object.title == this.title
        && object.description == this.description
        && object.createdDate == this.createdDate;
  }

  @override
  int get hashCode {
    return this.id.hashCode
         ^ this.title.hashCode
         ^ this.description.hashCode
         ^ this.createdDate.hashCode;
  }
}
