import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/entity.dart';

class CategoryEntity implements Entity<CategoryEntity> {
  /// Create a category entity.
  /// 
  /// The [title] and [createdDate] arguments must not be null.
  CategoryEntity({
    this.id,
    @required this.title,
    @required this.createdDate,
    this.description,
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
    return '[Category ID $id]: $title, $description, $createdDate.';
  }

  @override
  bool operator == (object) {
    return identical(this, object)
        || object is CategoryEntity
        && object.id == id
        && object.title == title
        && object.description == description
        && object.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode
         ^ title.hashCode
         ^ description.hashCode
         ^ createdDate.hashCode;
  }
}
