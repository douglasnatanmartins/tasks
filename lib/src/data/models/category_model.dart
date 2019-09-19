import 'package:tasks/src/data/contracts/model_contract.dart';

class CategoryModel implements ModelContract {
  int _id;
  String _title;
  String _description;

  int get id => this._id;
  String get title => this._title;
  String get description => this._description;

  set title(String title) {
    if (title.length <= 255) {
      this._title = title;
    }
  }

  set description(String description) {
    this._description = description;
  }

  /// Constructor of a category model object from a Map object.
  CategoryModel({int id, String title, String description}) {
    this._id = id;
    this._title = title;
    this._description = description;
  }

  /// Constructor of a category model object from a Map object.
  CategoryModel.from(Map<String, dynamic> object) {
    this._id = object['id'];
    this._title = object['title'];
    this._description = object['description'];
  }

  /// Returns a map object to representation of this object.
  @override
  Map<String, dynamic> toMap() {
    var result = Map<String, dynamic>();
    result['id'] = this._id;
    result['title'] = this._title;
    result['description'] = this._description;
    return result;
  }
}