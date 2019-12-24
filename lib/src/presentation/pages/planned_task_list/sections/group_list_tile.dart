part of '../planned_task_list_layout.dart';

class GroupListTile extends StatefulWidget {
  GroupListTile({
    Key key,
    @required this.date,
    @required this.items,
  }): assert(date != null),
      assert(items != null),
      super(key: key);

  final DateTime date;
  final List<TaskEntity> items;

  @override
  State<GroupListTile> createState() => _GroupListTileState();
}

class _GroupListTileState extends State<GroupListTile> {
  DateTime date;
  List<TaskEntity> items;

  @override
  void initState() {
    super.initState();
    date = widget.date;
    items = widget.items;
  }

  @override
  void didUpdateWidget(GroupListTile oldWidget) {
    if (oldWidget.items != widget.items) {
      items = widget.items;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<PlannedTaskListController>(context);
    
    String title;
    if (date == DateTimeUtil.onlyDate(DateTime.now())) {
      title = 'Today';
    } else {
      title = DateFormat.yMMMd().format(date);
    }

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(title),
        children: buildChildren(controller),
      ),
    );
  }

  List<Widget> buildChildren(PlannedTaskListController controller) {
    List<Widget> children = <Widget>[];

    for (var item in items) {
      int index = items.indexOf(item);
      children.add(
        GestureDetector(
          child: TaskListTile(
            data: item,
            onChanged: (TaskEntity updated) {
              controller.updateTask(updated, item);
            },
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/task',
              arguments: <String, dynamic>{
                'component': controller,
                'model': item,
              },
            );
          },
        ),
      );

      if (index < items.length) {
        children.add(
          Divider(
            color: Color(0xff989898),
          ),
        );
      }
    }

    return children;
  }
}
