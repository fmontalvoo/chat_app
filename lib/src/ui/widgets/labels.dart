import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function() onPressed;

  Labels({Key key, this.title, this.subtitle, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.title,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text(
              this.subtitle,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: this.onPressed,
          )
        ],
      ),
    );
  }
}
