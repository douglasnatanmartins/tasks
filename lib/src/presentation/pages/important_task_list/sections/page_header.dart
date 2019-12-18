part of '../important_task_list_layout.dart';

class _PageHeader extends StatelessWidget {
  /// Create a PageHeader widget.
  _PageHeader({
    Key key,
  }) : super(key: key);

  /// Build the PageHeader widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Important',
                style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 3.5),
              Text(
                'List of tasks by important',
                style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
