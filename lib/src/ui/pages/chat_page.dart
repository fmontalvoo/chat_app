import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat_app/src/ui/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _escribiendo = false;

  List<ChatMessage> mensajes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 1.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Text("Us"),
            radius: 20.0,
            backgroundColor: Colors.blue[100],
          ),
          SizedBox(width: 5.0),
          Text(
            "Usuario",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemCount: mensajes.length,
            itemBuilder: (BuildContext context, int index) => mensajes[index],
          )),
          Divider(height: 1.0),
          Container(
            height: 70.0,
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
                child: TextField(
              decoration:
                  InputDecoration.collapsed(hintText: "Escribir mensaje"),
              focusNode: _focusNode,
              controller: _controller,
              onSubmitted: _submit,
              onChanged: (texto) {
                setState(() {
                  if (texto.trim().length > 0)
                    _escribiendo = true;
                  else
                    _escribiendo = false;
                });
              },
            )),
            if (Platform.isAndroid)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                      icon: Icon(
                        Icons.send,
                      ),
                      onPressed: !_escribiendo
                          ? null
                          : () => _submit(_controller.text.trim())),
                ),
              ),
            if (Platform.isIOS)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: CupertinoButton(
                    child: Text("Enviar"),
                    onPressed: !_escribiendo
                        ? null
                        : () => _submit(_controller.text.trim())),
              )
          ],
        ),
      ),
    );
  }

  void _submit(String mensaje) {
    if (mensajes.isEmpty) return;
    print(mensaje);
    _controller.clear();
    _focusNode.requestFocus();
    setState(() {
      final chat = ChatMessage(
        uid: '123',
        message: mensaje,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 500)),
      );
      chat.animationController.forward();
      mensajes.insert(0, chat);
      _escribiendo = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage chat in mensajes) chat.animationController.dispose();
    super.dispose();
  }
}
