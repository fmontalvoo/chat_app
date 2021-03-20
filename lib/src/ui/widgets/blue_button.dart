import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;

  BlueButton({Key key, this.child, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 2.0,
        highlightElevation: 5.0,
        color: Colors.blue,
        textColor: Colors.white,
        shape: StadiumBorder(),
        child: Container(
          width: double.infinity,
          height: 50.0,
          alignment: Alignment.center,
          child: this.child,
        ),
        onPressed: this.onPressed);
  }
}
