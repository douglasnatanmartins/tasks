import 'package:flutter/material.dart';

class EmptyContentBox extends StatelessWidget {
  final String message;

  EmptyContentBox({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('lib/assets/images/character.png'),
          SizedBox(height: 10.0),
          Text(
            this.message,
            style: TextStyle(
              color: Colors.black
            )
          )
        ]
      )
    );
  }
}
