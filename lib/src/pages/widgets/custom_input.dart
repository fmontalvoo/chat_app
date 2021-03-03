import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final Widget prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;

  CustomInput(
      {Key key,
      this.hintText,
      this.obscureText = false,
      this.prefixIcon,
      this.keyboardType,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0, right: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5.0,
              )
            ]),
        child: TextField(
          controller: this.controller,
          autocorrect: false,
          obscureText: this.obscureText,
          keyboardType: this.keyboardType,
          decoration: InputDecoration(
            prefixIcon: this.prefixIcon,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.hintText,
          ),
        ));
  }
}
