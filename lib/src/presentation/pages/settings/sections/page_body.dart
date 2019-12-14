part of '../settings_layout.dart';

class _PageBody extends StatelessWidget {
  /// Create a _PageBody widget.
  _PageBody({
    Key key,
  }) : super(key: key);

  /// Build the _PageBody widget.
  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<SettingsController>(context);
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Container(
                    padding: const EdgeInsets.symmetric(vertical: 7.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[400],
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Text(
                      'About',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Version'),
                  trailing: StreamBuilder<PackageInfo>(
                    stream: controller.information,
                    builder: (context, snapshot) {
                      String version = '...';
                      if (snapshot.hasData) {
                        version = snapshot.data.version;
                      }
                      return Text(version);
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Third-party software'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
