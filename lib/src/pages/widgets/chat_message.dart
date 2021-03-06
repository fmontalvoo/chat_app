import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String uid;
  final String message;
  final AnimationController animationController;

  ChatMessage({Key key, this.uid, this.message, this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animationController,
        child: SizeTransition(
            sizeFactor: CurvedAnimation(
                parent: this.animationController, curve: Curves.easeOut),
            child:
                _Message(message: this.message, myMessage: this.uid == '123')));
  }
}

class _Message extends StatelessWidget {
  final bool myMessage;
  final String message;

  _Message({Key key, this.myMessage, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: this.myMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: this.myMessage
            ? EdgeInsets.only(left: 50.0, bottom: 7.0, right: 7.0)
            : EdgeInsets.only(left: 7.0, bottom: 7.0, right: 50.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: this.myMessage ? Color(0xFF4D9EF6) : Color(0xFFE4E5E8)),
        child: Text(
          this.message,
          textAlign: TextAlign.justify,
          style:
              TextStyle(color: this.myMessage ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
