import 'package:flutter/material.dart';

class EmptyContentBox extends StatelessWidget {
  final String message;
  final Color textColor;

  EmptyContentBox({
    this.message,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('lib/assets/images/character.png'),
          const SizedBox(height: 10.0),
          Text(
            this.message,
            style: TextStyle(
              color: this.textColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
