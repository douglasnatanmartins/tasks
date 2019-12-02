part of '../settings_page.dart';

class _PageHeader extends StatelessWidget {
  /// Create a _PageHeader widget.
  _PageHeader({
    Key key,
  }) : super(key: key);

  /// Build the _PageHeader widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Settings',
                style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 22.0,
                ),
              ),
              const SizedBox(height: 3.5),
              Text(
                'General settings for the application',
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
