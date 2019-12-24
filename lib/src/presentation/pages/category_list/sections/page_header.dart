part of '../category_list_layout.dart';

class _PageHeader extends StatelessWidget {
  /// Create a PageHeader widget.
  _PageHeader({
    Key key,
  }) : super(key: key);

  /// Build the PageHeader widget.
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat.EEEE().format(now),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${DateFormat.d().format(now)} ${DateFormat.MMMM().format(now)}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 15),
              Consumer<CategoryListController>(
                builder: (context, controller) {
                  return StreamBuilder(
                    stream: controller.categories,
                    builder: (context, snapshot) {
                      String description = '...';
                      if (snapshot.hasData) {
                        if (snapshot.data.isEmpty) {
                          description = 'You not have category';
                        } else if (snapshot.data.length == 1) {
                          description = 'You have 1 category';
                        } else {
                          description = 'You have ${snapshot.data.length} categories';
                        }
                      }

                      return Text(
                        description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 18,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
