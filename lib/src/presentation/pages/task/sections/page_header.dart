part of '../task_layout.dart';

class _PageHeader extends StatelessWidget {
  /// Create a _PageHeader widget.
  _PageHeader({
    Key key,
    @required this.data,
    @required this.onChanged,
  }): super(key: key);

  final TaskEntity data;
  final ValueChanged<TaskEntity> onChanged;

  /// Build the _PageHeader widget.
  @override
  Widget build(BuildContext context) {
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
                  child: _TaskTitleTextField(
                    data: data.title,
                    onChanged: (String title) {
                      onChanged(data.copyWith(
                        title: title,
                      ));
                    },
                  ),
                ),
                const SizedBox(width: 10),
                CircleCheckbox(
                  value: data.isDone,
                  onChanged: (bool checked) {
                    onChanged(data.copyWith(
                      isDone: checked,
                    ));
                  },
                ),
                _ImportantCheckbox(
                  value: data.isImportant,
                  onChanged: (bool checked) {
                    onChanged(data.copyWith(
                      isImportant: checked,
                    ));
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
