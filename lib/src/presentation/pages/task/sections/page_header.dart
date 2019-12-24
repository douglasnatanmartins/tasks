part of '../task_layout.dart';

class PageHeader extends StatelessWidget {
  /// Build the _PageHeader widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<TaskController>(context);
    var task = controller.task;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Back previous screen button.
          Hero(
            tag: 'previous-screen-button',
            child: FlatButton(
              padding: const EdgeInsets.all(10),
              shape: const CircleBorder(),
              child: const Icon(Icons.arrow_back),
              color: Colors.grey[400],
              textColor: Colors.black.withOpacity(0.75),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TaskTitleTextField(
                    data: task.title,
                    onChanged: (title) {
                      controller.setTaskTitle(title);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                CircleCheckbox(
                  value: task.isDone,
                  onChanged: (checked) {
                    controller.setTaskIsDone(checked);
                  },
                ),
                IconCheckbox(
                  value: task.isImportant,
                  icon: Icons.star,
                  onChanged: (checked) {
                    controller.setTaskIsImportant(checked);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
