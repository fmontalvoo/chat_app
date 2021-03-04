import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  Logo({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 170.0,
      child: Column(
        children: [
          Image(
            image: AssetImage('lib/assets/logo.png'),
          ),
          SizedBox(height: 20.0),
          Text(this.title, style: TextStyle(fontSize: 30.0))
        ],
      ),
    ));
  }
}
