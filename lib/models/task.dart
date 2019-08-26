class Task {
  Task({this.title});

  String title;
  bool _done = false;
  String _note;

  String getNote() {
    return _note;
  }

  void setNote(String note) {
    _note = note;
  }

  bool isDone() {
    return _done;
  }

  void setDone(bool done) {
    _done = done;
  }

}
