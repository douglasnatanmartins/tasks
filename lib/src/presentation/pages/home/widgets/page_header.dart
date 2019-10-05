import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/pages/settings/settings_page.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Planned',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600
                )
              )
            ]
          ),
          Hero(
            tag: 'on-hero-button',
            child: FlatButton(
              shape: CircleBorder(),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Icon(Icons.settings),
              color: Colors.grey.withOpacity(0.5),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage()
                  )
                );
              }
            )
          )
        ],
      ),
    );
  }
}
