import 'package:meta/meta.dart';
import 'package:tasks/src/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    int id,
    @required String title,
    @required DateTime createdDate,
    String description,
  }): super(
    id: id,
    title: title,
    description: description,
    createdDate: createdDate,
  );

  factory CategoryModel.from(Map<String, dynamic> object) {
    return CategoryModel(
      id: object['id'],
      title: object['title'],
      description: object['description'],
      createdDate: DateTime.parse(object['created_date']),
    );
  }
}
