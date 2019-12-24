part of '../task_layout.dart';

class BottomBar extends StatelessWidget {
  /// Build the BottomBar widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TaskController>(context);
    var task = controller.task;

    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Created on ${DateFormat.yMMMd().format(task.createdDate)}',
              style: Theme.of(context).textTheme.subtitle.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
            // Delete task button.
            IconButton(
              color: Colors.red[400],
              icon: const Icon(Icons.delete),
              onPressed: () async {
                var result = await showDialog(
                  context: context,
                  builder: (context) {
                    return TaskDeleteDialog();
                  },
                );

                if (result != null && result) {
                  controller.deleteTask();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
