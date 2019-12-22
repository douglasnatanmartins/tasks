part of '../category_layout.dart';

class PageHeader extends StatelessWidget {
  /// Build the PageHeader widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Back button.
              Hero(
                tag: 'previous-screen-button',
                child: FlatButton(
                  padding: const EdgeInsets.all(10),
                  shape: const CircleBorder(),
                  color: Colors.white,
                  child: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Header title.
              Expanded(
                child: HeaderTitle(),
              ),
              SettingPopupButton(),
            ],
          ),
        ],
      ),
    );
  }
}
