class ProjectModel {
  int _id;
  String _title;
  String _description;
  int _categoryId;

  int get id => _id;
  String get title => _title;
  String get description => _description;
  int get categoryId => _categoryId;

  set title(String title) {
    this._title = title;
  }

  set description(String description) {
    this._description = description;
  }

  set categoryId(int categoryId) {
    this._categoryId = categoryId;
  }

  ProjectModel({int id, String title, String description, int categoryId}) {
    this._id = id;
    this._title = title;
    this._description = description;
    this._categoryId = categoryId;
  }

  ProjectModel.from(Map<String, dynamic> project) {
    this._id = project['id'];
    this._title = project['title'];
    this._description = project['description'];
    this._categoryId = project['categoryId'];
  }

  Map<String, dynamic> toMap() {
    var project = Map<String, dynamic>();
    project['id'] = this._id;
    project['title'] = this._title;
    project['description'] = this._description;
    project['categoryId'] = this._categoryId;
    return project;
  }
}
