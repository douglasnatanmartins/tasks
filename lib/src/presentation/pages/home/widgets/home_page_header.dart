import 'package:flutter/material.dart';
import 'package:tasks/src/presentation/pages/settings/settings_page.dart';
import 'package:tasks/src/presentation/ui_colors.dart';

class HomePageHeader extends StatelessWidget {
  final int todayTasks;

  HomePageHeader({
    Key key,
    this.todayTasks = 0
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    String description;
    if (this.todayTasks == 0) {
      description = 'You not have task in today';
    } else if (this.todayTasks == 1) {
      description = 'You have 1 task in today';
    } else {
      description = 'You have ${this.todayTasks} tasks in today';
    }

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
                'Tenla: Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600
                )
              ),
              SizedBox(height: 10.0),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 15.0
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
              color: Colors.white,
              textColor: UIColors.Blue,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage()
                  )
                );
              },
            )
          )
        ],
      ),
    );
  }
}