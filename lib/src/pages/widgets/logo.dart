import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
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
          Text('Messenger', style: TextStyle(fontSize: 30.0))
        ],
      ),
    ));
  }
}
