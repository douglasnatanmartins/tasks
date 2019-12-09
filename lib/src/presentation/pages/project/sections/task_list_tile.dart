part of '../project_layout.dart';

class _TaskListTile extends StatefulWidget {
  /// Create a _TaskListTile widget.
  /// 
  /// The [data] and [onChanged] arguments must not be null.
  _TaskListTile({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): assert(data != null),
      assert(onChanged != null),
      super(key: key);

  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

  /// Creates the mutable state for this widget at a given location in the tree.
  @override
  State<_TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<_TaskListTile> {
  TaskEntity data;
  TextDecoration decoration;

  /// Called when this state first inserted into tree.
  @override
  void initState() {
    super.initState();
    this.data = this.widget.data;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(_TaskListTile old) {
    if (old.data != this.widget.data) {
      this.data = this.widget.data;
    }

    super.didUpdateWidget(old);
  }

  /// Called when this state removed from the tree.
  @override
  void dispose() {
    super.dispose();
  }

  /// Build the TaskListTile widget with state.
  @override
  Widget build(BuildContext context) {
    if (this.data.isDone) {
      this.decoration = TextDecoration.lineThrough;
    } else {
      this.decoration = TextDecoration.none;
    }

    return ListTile(
      leading: CircleCheckbox(
        value: this.data.isDone,
        onChanged: (bool checked) {
          setState(() {
            this.data = this.data.copyWith(isDone: checked);
            this.widget.onChanged(this.data);
          });
        }
      ),
      title: Text(
        this.data.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          decoration: decoration,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: this.data.isImportant ? Colors.yellow.shade600 : null,
        ),
        onPressed: () {
          setState(() {
            this.data = this.data.copyWith(
              isImportant: !this.data.isImportant
            );
            this.widget.onChanged(this.data);
          });
        },
      ),
      onTap: () {
        final controller = Provider.of<ProjectController>(context);
        Navigator.of(this.context).pushNamed(
          '/task',
          arguments: <String, dynamic>{
            'component': controller,
            'model': this.data,
          },
        );
      },
    );
  }
}
