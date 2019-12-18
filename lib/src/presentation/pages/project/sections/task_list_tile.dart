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
    data = widget.data;
  }

  /// Called when a dependency of this state object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// Called whenever the widget configuration changes.
  @override
  void didUpdateWidget(_TaskListTile old) {
    if (old.data != widget.data) {
      data = widget.data;
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
    if (data.isDone) {
      decoration = TextDecoration.lineThrough;
    } else {
      decoration = TextDecoration.none;
    }

    return ListTile(
      leading: CircleCheckbox(
        value: data.isDone,
        onChanged: (bool checked) {
          setState(() {
            data = data.copyWith(isDone: checked);
            widget.onChanged(data);
          });
        }
      ),
      title: Text(
        data.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          decoration: decoration,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.star,
          color: data.isImportant ? Colors.yellow.shade600 : null,
        ),
        onPressed: () {
          setState(() {
            data = data.copyWith(isImportant: !data.isImportant);
            widget.onChanged(data);
          });
        },
      ),
      onTap: () {
        var controller = Provider.of<ProjectController>(context);

        Navigator.of(context).pushNamed(
          '/task',
          arguments: <String, dynamic>{
            'component': controller,
            'model': data,
          },
        );
      },
    );
  }
}
