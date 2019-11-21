import 'package:meta/meta.dart';
import 'package:tasks/src/core/contracts/model_contract.dart';

class CategoryModel implements ModelContract {
  /// Create a category model.
  CategoryModel({
    int id,
    String description,
    @required String title,
    @required DateTime created,
  }) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._created = created;
  }

  /// Constructor of a category model object from a Map object.
  /// 
  /// The [data] argument must not be null.
  CategoryModel.from(Map<String, dynamic> data) {
    this._id = data['id'];
    this._title = data['title'];
    this._description = data['description'];
    this._created = DateTime.parse(data['created']);
  }

  int _id;
  String _title;
  String _description;
  DateTime _created;

  /// Get the category id.
  int get id => this._id;

  /// Get the category title.
  String get title => this._title;

  /// Get the category description.
  String get description => this._description;

  /// Get date the category was created.
  DateTime get created => this._created;

  /// Set new category title.
  /// 
  /// The [title] argument must not be null.
  set title(String title) {
    this._title = title;
  }

  /// Set new category description.
  /// 
  /// The [description] argument must not be null.
  set description(String description) {
    this._description = description;
  }

  /// Returns a map object to representation of this model object.
  @override
  Map<String, dynamic> toMap() {
    var result = Map<String, dynamic>();
    result['id'] = this._id;
    result['title'] = this._title;
    result['description'] = this._description;
    result['created'] = this._created.toString();
    return result;
  }

  @override
  bool operator == (object) {
    return object is CategoryModel
        && object.id == this.id
        && object.title == this.title
        && object.description == this.description
        && object.created == this.created;
  }

  @override
  int get hashCode {
    return this.id.hashCode
         ^ this.title.hashCode
         ^ this.description.hashCode
         ^ this.created.hashCode;
  }
}
