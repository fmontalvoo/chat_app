import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            '¿No tienes cuenta?',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 20.0),
          FlatButton(
            child: Text(
              'Crea una ahora!',
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
