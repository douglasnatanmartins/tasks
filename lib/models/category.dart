import 'package:tasks/models/task.dart';

class Category {
  String title;
  String description;
  List<Task> tasks = [];

  Category({this.title, this.description, this.tasks});
}
